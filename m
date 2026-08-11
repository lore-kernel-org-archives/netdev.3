Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051B2E612E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425693; cv=none; b=pKIA0yDgly/KejR9/Q8FfwnZhJNcU48PkkbvfvPr9dmaEd/DC5Nb/ZY/Ff7CpG/a3L25lYWoxafR78oQt7C2r6NkwgKeSe5kbTjXhqYQtTrMyGLb+pqLqFly5X68ZRNMFlAn22Maoohcv9brvm+HriJYLYrJiVFeMkvvHDU8hCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425693; c=relaxed/simple;
	bh=zNfHCgmhyORWyW5rib6dJI1pN7cDpr+bzaFyCgfTOsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y45cV4awe+Iy6wFarXnluuFy0o8smXVogO3IGhLwQE+erk7xDNaTMHzzrsnzXllR/PCSKGYsBJ5bWfjl6AKeIibZ3qP2WcCd9Eh4LCnMiechxrEnVo9G+tYaj4FPBjF6cZdpQc8vafdkRKnt/AjcDc4godgyfsZicxAT8yIbYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UunVy3Nf; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UunVy3Nf"
Message-ID: <55c5f2ed-3e60-4575-ad16-b9a355bdb11b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786425688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=071dyf+3MXCou9DnxXCM3S8UDU90Zr9evCmWuFspqPM=;
	b=UunVy3NfDzXto5DoJwcc2pDeaktwKetuxbnpUi2u3yv7ojRs42HJiFPnNIVBszB0Z8/Isc
	qHWxaJuuNxzNGPu84kZjtxFDEFSIp0OwKfn2qqAuKxQxCbxoVAuIxge5g8IDNj0cJGkwIf
	03I9FiqiEqN2hVA6IkQNqUW8dNg4rgA=
Date: Tue, 11 Aug 2026 13:21:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] af_packet: Don't send zero-byte data in
 tpacket_snd().
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com
References: <20260810150447.1220864-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260810150447.1220864-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/10/26 11:04 PM, Eric Dumazet wrote:
> syzbot reported a WARNING in __dev_queue_xmit() triggered via tpacket_snd():
>
> skb_assert_len
> WARNING: at include/linux/skbuff.h:2753 skb_assert_len
> WARNING: at __dev_queue_xmit+0x21bc/0x4970 net/core/dev.c:4781
>
> Call Trace:
>   <TASK>
>   dev_queue_xmit include/linux/netdevice.h:3448 [inline]
>   packet_xmit+0x243/0x310 net/packet/af_packet.c:276
>   tpacket_snd net/packet/af_packet.c:2907 [inline]
>   packet_sendmsg+0x28d6/0x4eb0 net/packet/af_packet.c:3134
>
> When sending 0-byte packets via TPACKET ring buffer on devices with no
> hard header (e.g. dev->hard_header_len == 0), tpacket_fill_skb()
> populates an skb with skb->len == 0 and returns 0. tpacket_snd() then
> forwards this empty skb to packet_xmit(), causing __dev_queue_xmit() to
> hit skb_assert_len(skb).
>
> Similar checks exist in packet_snd() via commit dc633700f00f
> ("net/af_packet: check len when min_header_len equals to 0") and in
> packet_sendmsg_spkt() via commit 6a341729fb31 ("af_packet: Don't send
> zero-byte data in packet_sendmsg_spkt().").
>
> Return -EINVAL in tpacket_fill_skb() when skb->len is zero to reject
> zero-length packets in tpacket_snd().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a79e807.01d0871a.3a0d52.00ac.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap") would be more 
accurate but it makes no difference for backports.


> ---
>   net/packet/af_packet.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 435756877abaa1ab4c0edcc2346bcb2de3625605..103025c4625fb317e0ecedd12c15857af86b7a65 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2660,6 +2660,9 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>   		len = ((to_write > len_max) ? len_max : to_write);
>   	}
>   
> +	if (unlikely(!skb->len))
> +		return -EINVAL;
> +
>   	packet_parse_headers(skb, sock);
>   
>   	return tp_len;
