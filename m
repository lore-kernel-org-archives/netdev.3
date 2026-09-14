Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93D420888;
	Mon, 14 Sep 2026 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385045; cv=none; b=EtRoQm15kXblii1tzQw9YL6oEbjnIkGlrBdioZkWrEZPsUfQw/GLnLQ+Dx2jhf6I9VIGsXP3laog3NGWXqP3oEZFQMDocRdC2ARvZYWE81bjNoNDckg79bAJHADT4smxCoEbf2Cpfip93fAbLfwb8twdg8XPrj2uAtGCwZ6TG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385045; c=relaxed/simple;
	bh=XPkI82naGL2W8v1pno7Rljm8YZUwupXcUZf15YreTrk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbEPdI3R8bGnVegrp9o2vIOi8MxiC7i6n9QDd+RyUKg4tPVxpURlfXpw6FjLC1fzCHWcwDsDsPCaUP+NwJzU0slysAXKgWHRczyj8HKNkvOri/DB56yl3slm703IcDVfL9ymkASLsJedVPexoWYsYzzj2aAbVlnyaWIsyjxpsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdG0AfK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdG0AfK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6117B1F000FF;
	Mon, 14 Sep 2026 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789385043;
	bh=HDqGrd+54gaw8Z66CDOqX+sB4hcrZCvkqRk211eNBNo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bdG0AfK+VF5DGeL5bw1hrPzQWVSIosHjHJHnEbjSfrTWZXCwcSJ4pdcsI2cBqfvRO
	 CNMBgeMOGaq/SI8Hgn92xaXnV3s5utn9dk42l7xY48gSI3tx49+MvhNIMcuGLDtySv
	 Zdw4VuaUHFyQ3TbVfFKjzVokABdoJb7GUQGnVWLX6yxSrSn60RzibsIIl09ocLR7Lf
	 uCo74JNRT7fO1g4vy1L4gRML0iXCIV64HvhPuVYaTXZK0mllXjJ8i/48UBkcYaybN+
	 ZlRVPIa9HNb9iX1JwZU9WULokwR3q3H4TQOfvT9ikvnd+gFvZ5ekvFlnteYkGAI8a3
	 8AUQ2rbbseJ9w==
Subject:
 Re: [PATCH net] net/packet: preserve TX_RING progress on a later frame error
From: netdev-bot+sashiko@kernel.org
To: markdamirkan@gmail.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, johann.baudy@gnu-log.net, horms@kernel.org,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com
Date: Mon, 14 Sep 2026 11:24:02 +0000
Message-ID: <178938504289.22033.16213258145631477368@kernel.org>
In-Reply-To: <20260913-b4-send-packet-tx-progress-v1-1-01b99569cda6@gmail.com>
References: <20260913-b4-send-packet-tx-progress-v1-1-01b99569cda6@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix: the bug class named in the commit subject
  ("preserve TX_RING progress on a later frame error") stays reachable…

--

net/packet: preserve TX_RING progress on a later frame error

This changes the frame validation error path in tpacket_snd() so that the
already-transmitted byte count is returned instead of the per-frame error
when at least one frame has already been sent.  The failing frame is still
marked TP_STATUS_WRONG_FORMAT.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 76bde7906d494..b7e1848b61865 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2893,7 +2893,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  				continue;
>  			} else {
>  				status = TP_STATUS_WRONG_FORMAT;
> -				err = tp_len;
> +				err = len_sum ? : tp_len;
>  				goto out_status;
>  			}
>  		}

[Severity: High]
The commit subject says "preserve TX_RING progress on a later frame error",
but only the validation error exit is converted.  Are the other exits of
tpacket_snd() that can also be reached with len_sum > 0 meant to keep
returning the errno?

len_sum is only accumulated at the bottom of the loop, after the frame has
been handed to packet_xmit():

net/packet/af_packet.c:tpacket_snd() {
	...
		packet_increment_head(&po->tx_ring);
		len_sum += tp_len;
	} while (1);
	...
}

so on any iteration after the first, the transmit failure exit is reachable
with len_sum > 0 and still overwrites it:

net/packet/af_packet.c:tpacket_snd() {
	...
		err = packet_xmit(po, skb);
		if (unlikely(err != 0)) {
			if (err > 0)
				err = net_xmit_errno(err);
			if (err && __packet_get_status(po, ph) ==
				   TP_STATUS_AVAILABLE) {
				/* skb was destructed already */
				skb = NULL;
				goto out_status;
			}
	...
}

Here err carries the negative xmit errno (for example -ENOBUFS derived from
NET_XMIT_DROP, or -ENETDOWN) and len_sum is discarded, so send() reports
failure even though earlier frames were already handed to the device.  Isn't
that the same behaviour the changelog describes as wrong for the validation
path?

The wait path has the same shape:

net/packet/af_packet.c:tpacket_snd() {
	...
			if (need_wait && packet_read_pending(&po->tx_ring)) {
				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
				if (timeo <= 0) {
					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
					goto out_put;
				}
	...
}

On a blocking socket with SO_SNDTIMEO, once frame N has been transmitted and
the head frame is no longer TP_STATUS_SEND_REQUEST while completions are
still pending, this returns -ETIMEDOUT or -ERESTARTSYS with len_sum > 0.

With the patch applied, the four exits that can see len_sum > 0 disagree:
the sock_alloc_send_skb() failure path returns len_sum, the validation path
now returns len_sum, and the packet_xmit() failure and wait-timeout paths
return a negative errno.  Can userspace still derive a single interpretation
of the send()/sendto() return value for a PF_PACKET TX_RING socket?

Would it make sense to either apply the same treatment to the xmit and
timeout exits, or narrow the changelog to the validation error and state why
the remaining exits intentionally keep reporting the errno?

The changelog also says:

> Return the completed byte count when it is nonzero, as the allocation
> failure path already does.

The allocation failure path uses "if (likely(len_sum > 0))" while the new
code uses "len_sum ? :", which also takes the len_sum branch for a negative
len_sum.  Is the difference intentional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913-b4-send-packet-tx-progress-v1-1-01b99569cda6%40gmail.com
