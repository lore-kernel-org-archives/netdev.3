Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705351;
	b=WPdRgSUyOIHq+16kBHKStEqEamlb9af+s0gZzMBsxN/a8NxUV6CL4FMjiM+14Dm6rmrD
	 fU/rNWYYicn6bB+vpsPPXeOUUTjjrv0htviqItXHskPAvzU5UMerweNqr1lYyygadTJc1
	 3QxUg5Cpo7S/6gLXNiR9nN3GJiHbWB/CZSF5g+62LC5Kteehhjxma3BpwMZLigG11KSeX
	 asa8bJh95wF6PZkTk1FfJMcqyuiq4Sz4aPJbM/IF4KWutLdeeHGw2H3u+MGc9X+SIDMwQ
	 NS1HQjYXpiPcCY90TeBM117uNN6qYUA8Y2DIj7J+ElNFtNs6nhSf6HTylFX9VYZ0rLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705351;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dWaEvAk5n6dyTmdK8oBdw/e0DOhzHuEIwwmY2X8xsdQ=;
	b=EnpKL+1loxVCm7d0SUc6/eJdFY2117xmuDbgx6AzjSJMfWpuJPsmIl2wQxloECxns+xd
	 dkOLJvr++XqV4cLuWyAYmsCeRSKy1738EKxoUd4qGjy9eNOvybDVhtR5MN6U8Pr1+HojZ
	 WN020TSgcje9PRBGjCsYS56D1inh2jaMl6fnRl3Zc2HHJP1pYIHy3gJDNz44Igf/4WrAk
	 zGiw5ZabSCx49OmXev9NhyJuSvKSfrlKWhQ4Rcb1UNlwFXwhqbmSnlRSmkS8HoBdjY0oG
	 f8R8x+HE1KAQaSfBMsR43ww6TwyvA2Bj6P4ASdOyPyqZj/nbFwcYF4taRMezcUPyJLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8xyHbZw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C05606A819;
	Tue,  3 Nov 2026 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8xyHbZw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD2B1F00ADC;
	Tue,  3 Nov 2026 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705350;
	bh=dWaEvAk5n6dyTmdK8oBdw/e0DOhzHuEIwwmY2X8xsdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U8xyHbZw1v6Io0vyp9fqViphsvkB49tN2c9jbeQwOp0fyVm7Q7TP61p7DTfVR8kVl
	 DvYILhgLIjYpSx+cm1hdw1zACz6KvLzD8KTu8PLIN8Um2CE3PJJTgySf6lc86tfPf1
	 0N6sXkiOWfAT4vA0Ls146QieA8LOELHSHXkawNzdZ5oG61JX3r2nIjq8ZExthKV+bU
	 9sOVUwYMoT3+IZj+XZSfgeQtmfFdZfi3jGFxxRjebf/ruFb4/USJiZIutV7PEt1LAG
	 9/J1OO6oZ9/5sMSo+KQ1QJJbW22RrUcyxvyzLPriCVBPRAJ6e/TMSfdComa9XKui0t
	 a4CmS0a/JmG/A==
Subject: Re: [PATCH net 2/3] nfc: rawsock: free the response skb when the data
 exchange fails
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 11:29:09 +0000
Message-ID: <179370534977.488856.16044091995627562650@kernel.org>
In-Reply-To: <179335864272.64596.4931238314416806197@gmail.com>
References: <179335864272.64596.4931238314416806197@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Double free of the NFC-DEP response skb in
  rawsock_data_exchange_complete() (net/nfc/rawsock.c), added by this…

--

nfc: rawsock: free the response skb when the data exchange fails

This patch makes rawsock_data_exchange_complete() free the response skb
on the error path as well as on success. According to the commit message,
HCI and NCI pass a response skb to the callback together with a non-zero
err, so that skb leaks on every failed exchange.

> diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
> index f7d7a599fade7..74ef3906c2eda 100644
> --- a/net/nfc/rawsock.c
> +++ b/net/nfc/rawsock.c
> @@ -156,8 +156,9 @@ static void rawsock_data_exchange_complete(void *context, struct sk_buff *skb,
>  
>  	pr_debug("sk=%p err=%d\n", sk, err);
>  
> +	/* skb may carry the response even when the exchange failed */
>  	if (err)
> -		goto error;
> +		goto error_skb;

[Severity: Critical]
Can this double free the NFC-DEP response skb on the digital stack?

The commit message says:

  Free the skb on the error path too; it is NULL when the error does not
  come with a response (digital, timeouts, device close)

That is true for digital_in_send_complete() in net/nfc/digital_core.c,
which frees the skb and passes NULL. It is not true for
digital_in_recv_dep_res() in net/nfc/digital_dep.c. Several of its error
branches jump to exit while resp is still a live skb, for example:

	if (DIGITAL_NFC_DEP_NAD_BIT_SET(pfb)) {
		rc = -EIO;
		goto exit;
	}

The other such branches are the digital_skb_pull_dep_sod() failure, the
-EMSGSIZE check on resp->len, a NACK PDU, an ACK PNI mismatch, and an ACK
with no chaining_skb.

At exit, the function calls the callback and then frees resp itself:

exit:
	data_exch->cb(data_exch->cb_context, resp, rc);

error:
	kfree(data_exch);
	...
	if (rc)
		kfree_skb(resp);

With this change, rawsock_data_exchange_complete() frees resp first.
digital_in_recv_dep_res() then frees it a second time.

A raw socket can reach this path. rawsock_connect() passes
NFC_PROTO_NFC_DEP through nfc_activate_target() to
digital_activate_target(), which sets ddev->curr_protocol. After that,
digital_in_send() sends the exchange through digital_in_send_dep_req(),
with rawsock_data_exchange_complete() as the callback. The remote peer
controls the PFB bits and length of the DEP_RES frame, so it can trigger
any of these error branches.

The data_exchange_cb_t kernel-doc in include/net/nfc/nfc.h doesn't say
who owns @skb when @err is non-zero, and the producers handle it
differently:

  - HCI and NCI hand ownership to the callback.
  - digital_core frees the skb and passes NULL.
  - digital_dep passes the skb and frees it afterwards.

Would it make sense to fix the ownership rule in the producers as well?
For example, digital_in_recv_dep_res() could pass NULL on error, or stop
freeing resp after the callback. The rule could then be documented in
the kernel-doc.

The later patch in this series, "nfc: llcp: free the response skb when
the data exchange fails", only changes nfc_llcp_recv() and does not touch
digital_dep.c. So the double free is still there at the end of the
series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179335864271.64596.805818095553030218%40gmail.com
