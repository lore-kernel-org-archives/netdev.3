Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF21E5714;
	Mon, 13 Jul 2026 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976055; cv=none; b=hKKtg+00kbRUDmqnKmzN/oVEdDPsEEv3i+r/ql2wikqlu9hVAKL85HxG8xAWhxb1GmmNwsike3MG4Kh2Z7Nqyf+qWxCT1HvMZS+9vNhxgelp3Wur8uptzsfC+ndnghg3wfXZreZdaRTz0JZ6JE4IIvWwBauTW81t0/OklhqX070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976055; c=relaxed/simple;
	bh=c+AX+Imm5by6E4SULREbGaKUUHb4o4SA86I4EsrTr2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lju3HSpmRU8k4+W9+hOPVXyV/6yiU14zjUQNFSXHDbEp9Q8UbMJ1Sm/SqcZrTB0P5j3O4Pf+EbTC2ikKbdQfjAiuyeF51kpCRrtxJzdJ/Ov3L5G7HqPJm64bPFoDGyJQVNBdn4HFBp+0drG+CRZ1ODllreQepna/aLrcnwhsSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eteJLydj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eteJLydj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O2v/KwCh4Ct/gxRKhOZYLSeo1HEsnSVHdgHCkxMIMkQ=; b=eteJLydjBuTT47AbmPN0dYcTma
	Y0YobMjVk0A2W2zsIcEJDLMXl+gvkTaMRNtvvlbvPiJLS62OZAhXHTTbCIdqhW9haZHwvbJJY7g3V
	B7uHNb30qjRlKbSHHauLR1hjMKcpG/wlGC4QLzEoey+mAYtT6rGHgynjmNHvLPzu6VV2uUOGpr5Gx
	BnJVWcLrSpxRyZsRtTeErGxX89zSG8dlqDXnIZS67TOULRRv7HrOvgQO4/q3OMyzC1ILBY+u1bRaC
	z2v1WYx77/ZuhxJptm+6A75VyhYgUAiF4kiHyQAvv7blhEseIubVEaz4TVV35PyZRUgH0Z2942hB5
	rMonm8Gw==;
Received: from [179.96.247.152] (helo=[192.168.1.16])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wjNfB-00Efqv-PT; Mon, 13 Jul 2026 22:54:06 +0200
Message-ID: <33cf2fc8-37ea-4a45-8794-e3bd12e06cbb@igalia.com>
Date: Mon, 13 Jul 2026 17:54:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
To: jmaloy@redhat.com, davem@davemloft.net, ying.xue@windriver.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, erik.hugne@gmail.com
References: <20260713204940.647668-1-koike@igalia.com>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <20260713204940.647668-1-koike@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(cc + Erik)

On 7/13/26 5:49 PM, Helen Koike wrote:
> cmd->dumpit callback can return a negative errno, causing an infinite
> loop due to the while(len) condition. As the loop never terminates,
> genl_mutex is never released, and other tasks waiting on it starve in D
> state.
> 
> Check dumpit's return value, propagate it and jump to err_out on error.
> 
> Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=85d0bec020d805014a3a
> Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
> Signed-off-by: Helen Koike <koike@igalia.com>
> ---
> 
> Tested locally using syzbot reproducer.
> ---
>   net/tipc/netlink_compat.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
> index 2a786c56c8c5..d9a4f94ea2d4 100644
> --- a/net/tipc/netlink_compat.c
> +++ b/net/tipc/netlink_compat.c
> @@ -221,6 +221,10 @@ static int __tipc_nl_compat_dumpit(struct tipc_nl_compat_cmd_dump *cmd,
>   		int rem;
>   
>   		len = (*cmd->dumpit)(buf, &cb);
> +		if (len < 0) {
> +			err = len;
> +			goto err_out;
> +		}
>   
>   		nlmsg_for_each_msg(nlmsg, nlmsg_hdr(buf), len, rem) {
>   			err = nlmsg_parse_deprecated(nlmsg, GENL_HDRLEN,

