Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320124DBD64;
	Thu,  3 Sep 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449017; cv=none; b=PnbyLL9/nQMwD9O2+pQN9tqvfvK74i2p1runppCNtC6Ovu2G6l9TjLdjo+ooay57xvBQ/u0dR/guPfWuTTXO/xSA73xNxCzYoa72qpFAVvVvO2FLP/ihP/MHr9ueVa16gdMIJ1fjSht8PgnXm9YZW7pI/dcO3V7z9y2PFb/71/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449017; c=relaxed/simple;
	bh=nUQ0WsBFZ2Yb6ancdOi0VOG5/Ts8us9ZZTML6ezNK74=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heh1v6HXu4u4PE1Uuz1SM1wZVyTuTycEo7fOdrQtdL/IN0VOB8Z4q3aq1zHwsfu5LgxkMNHOu6CnIsueeLoX4LGUqTZ9i9I2Ct0GOdUzHSSdsNGgFFx9TkrkgQ4x+2GV7+74xZ3a2pbFFCJ3bgiWsyyE9JRXE7cuJS6Dxye2ncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUYs3NaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUYs3NaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985BA1F00A3D;
	Thu,  3 Sep 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788449016;
	bh=951yxPP28ISDpMBkAXxtv2jRGbNBHcBVyMcI+H38kV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XUYs3NaGCWqynIino2f4hUvRo8xN6NM3XuCxybJKjv8HrE12rFAKuipdsemaO9aOk
	 fmJzlhafrNgeRVEK4ikmPJbtvxyVFLn6KaoMyz4tKeakrwO3RYkzpMutVQO7he2ASj
	 44BsxzItJLdHUH0BPUWbIOOXRT9dAcYnPuxS+hA6vyc+Fn9qrENjyR8gwfw04rTaTR
	 19uC4xqiGpJyrRTWiI4SOOr/5t+E8b+bXh42RpMK9xX0AMGobFL4Jab2s4Cp2Kql9F
	 qcy9Ik7tBEMH0/mOH6j/NKJKe1KeGoJ/SSbJCFWz4knQ5tqjW/SqMf3UvdX716ZmWh
	 jql75PW1AC04A==
Subject: Re: [net,2/2] enic: match mailbox replies to request numbers
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 sebaddel@cisco.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 15:23:35 +0000
Message-ID: <178844901513.3394541.14778454790618042828@kernel.org>
In-Reply-To: <20260830-b4-enic-v2-mbox-fixes-net-v1-2-23adf9bfd426@cisco.com>
References: <20260830-b4-enic-v2-mbox-fixes-net-v1-2-23adf9bfd426@cisco.com>
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

- [High] enic_mbox_vf_handle_reply()
  (drivers/net/ethernet/cisco/enic/enic_mbox.c:403) now requires the…

--

enic: match mailbox replies to request numbers

This adds a message-number match to the VF mailbox reply path: outgoing
replies now reuse the initiating message number, the VF records both the
expected reply type and the expected message number, and a reply is only
accepted when both match.  The expected-reply state is moved under a new
spinlock and the message counter is kept monotonic across an admin channel
reopen.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index ad79d3951f3d..5c93ca49552a 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c

[ ... ]

> @@ -68,7 +71,21 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
>  		goto unlock;
>  	}
>  
> -	enic_mbox_fill_hdr(enic, buf, msg_type, dst_vnic_id, total_len);
> +	/* Replies reuse the initiating message number.  Requests and
> +	 * notifications allocate a new one.
> +	 */
> +	if (!reuse_msg_num)
> +		msg_num = ++enic->mbox_msg_num;
> +	if (expected_reply) {
> +		reinit_completion(&enic->mbox_comp);
> +		spin_lock_bh(&enic->mbox_state_lock);
> +		enic->mbox_expected_reply = expected_reply;
> +		enic->mbox_expected_msg_num = msg_num;
> +		spin_unlock_bh(&enic->mbox_state_lock);
> +		reply_expected = true;
> +	}

[ ... ]

> @@ -178,8 +243,8 @@ static int enic_mbox_pf_handle_capability(struct enic *enic, void *msg,
>  	reply.reply.ret_major = cpu_to_le16(0);
>  	reply.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
>  
> -	return enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REPLY, vf_id,
> -				  &reply, sizeof(reply));
> +	return enic_mbox_send_reply(enic, ENIC_MBOX_VF_CAPABILITY_REPLY, vf_id,
> +				    &reply, sizeof(reply), msg_num);
>  }

[ ... ]

> @@ -324,75 +389,57 @@ static void enic_mbox_pf_process_msg(struct enic *enic,
> +static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
> +				      void *payload, u64 msg_num)
>  {
> +	struct enic_mbox_generic_reply *reply = payload;
> +	u16 ret_major = le16_to_cpu(reply->ret_major);
> +	u64 expected_msg_num;
> +	u8 expected_type;
> +
> +	spin_lock_bh(&enic->mbox_state_lock);
> +	expected_type = enic->mbox_expected_reply;
> +	expected_msg_num = enic->mbox_expected_msg_num;
> +	if (expected_type != reply_type || expected_msg_num != msg_num) {
> +		spin_unlock_bh(&enic->mbox_state_lock);
>  		netdev_warn(enic->netdev,
> -			    "MBOX: stale capability reply (expected %u), drop\n",
> -			    READ_ONCE(enic->mbox_expected_reply));
> +			    "MBOX: stale reply %u/%llu (expected %u/%llu), drop\n",
> +			    reply_type, (unsigned long long)msg_num,
> +			    expected_type, (unsigned long long)expected_msg_num);
>  		return;
>  	}

[Severity: High]
What happens when the VF runs this code against a PF that does not echo
msg_num?

The expected number armed in enic_mbox_send_msg_id() is the VF's own
private counter value:

	if (!reuse_msg_num)
		msg_num = ++enic->mbox_msg_num;
	if (expected_reply) {
		...
		enic->mbox_expected_msg_num = msg_num;

so acceptance now depends on the peer returning that exact value.  The
mismatch branch in enic_mbox_vf_handle_reply() returns without calling
complete(&enic->mbox_comp), so enic_mbox_wait_reply() runs out its 3000 ms
and returns -ETIMEDOUT for every reply that carries a different number.

The only PF implementation that can be inspected is the in-tree one added
by the commit named in the Fixes: tag, and before this patch it stamped a
fresh number on every outgoing message, replies included:

drivers/net/ethernet/cisco/enic/enic_mbox.c:enic_mbox_fill_hdr() {
	...
	hdr->msg_num = cpu_to_le64(++enic->mbox_msg_num);
}

That is also why this patch has to convert
enic_mbox_pf_handle_capability(), enic_mbox_pf_handle_register() and
enic_mbox_pf_handle_unregister() over to enic_mbox_send_reply(..., msg_num).

Given that, is this statement in the commit message accurate?

    Reply-number echo is part of the established version-1 protocol, so this
    remains compatible with deployed V2-capable PF implementations that
    already echo msg_num.

For a VF with this patch talking to a PF running the pre-patch in-tree
driver (older host kernel than guest, or a partial stable backport that
picks up only the VF-side hunks), does the capability handshake fail
outright?

enic_mbox_vf_capability_check() -> enic_mbox_wait_reply() returns
-ETIMEDOUT, and in enic_probe() that error is fatal:

		err = enic_mbox_vf_capability_check(enic);
		if (err) {
			dev_err(dev, "MBOX capability check failed: %d\n", err);
			goto err_out_admin_close;
		}

so the SR-IOV V2 VF netdev is never registered.  On the reset path,
enic_admin_chan_reopen() calls enic_admin_channel_close() on the same
error, leaving the VF without PF-driven link state or registration.

Would it make sense to keep a fallback here, for example accepting a reply
whose msg_num is 0 (or otherwise not echoed), or gating the strict match on
the negotiated pf_cap_version, so that the VF does not depend on peer
behaviour that this same patch introduces?

> -	if (le16_to_cpu(reply->reply.ret_major) == 0)
> -		enic->pf_cap_version = le32_to_cpu(reply->version);
> -	else
> -		netdev_warn(enic->netdev,
> -			    "MBOX: PF rejected capability request: %u/%u\n",
> -			    le16_to_cpu(reply->reply.ret_major),
> -			    le16_to_cpu(reply->reply.ret_minor));
> -	complete(&enic->mbox_comp);
> -}

[ ... ]

> @@ -571,32 +620,31 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
>  int enic_mbox_vf_capability_check(struct enic *enic)
>  {
>  	struct enic_mbox_vf_capability_msg req = {};
> +	u32 version;
>  	int err;
>  
> -	enic->pf_cap_version = 0;
> -	reinit_completion(&enic->mbox_comp);
> -	WRITE_ONCE(enic->mbox_expected_reply, ENIC_MBOX_VF_CAPABILITY_REPLY);
> +	WRITE_ONCE(enic->pf_cap_version, 0);
>  	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
>  
> -	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REQUEST,
> -				 ENIC_MBOX_DST_PF, &req, sizeof(req));
> -	if (err) {
> -		WRITE_ONCE(enic->mbox_expected_reply, 0);
> +	err = enic_mbox_vf_send_request(enic,
> +					ENIC_MBOX_VF_CAPABILITY_REQUEST,
> +					ENIC_MBOX_VF_CAPABILITY_REPLY,
> +					&req, sizeof(req));
> +	if (err)
>  		return err;
> -	}
>  
>  	err = enic_mbox_wait_reply(enic, 3000);
> -	WRITE_ONCE(enic->mbox_expected_reply, 0);
> +	version = READ_ONCE(enic->pf_cap_version);
>  	if (err) {
>  		netdev_warn(enic->netdev,
>  			    "MBOX: no capability reply from PF\n");
>  		return err;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426%40cisco.com
