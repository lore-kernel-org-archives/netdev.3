Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657293;
	b=4J23AkA8KQAkSxZ9aCiPlZxXiA1DAHO2iwBA09t24ejdlADaMiDKlHlmQOZ75Y5Ef0ST
	 jPmlakeOKXX24n1qo3tLil07uzrpZAT1SkyBSQF0dZJN1bquragtqE/hSDVPlFbAcQ256
	 kiKXmwS6IspUAMvOWYhoRkgIWQfSSVUfmj/Zs6t/9TqoeOY/KlSaEkBYwMjIy15DnlyKZ
	 ctmBu7SVxZ/du9Ij4hc3fWemj0CyblvTtxduetP7RlWAROKv+YdHRXT0/+MJV2+Vjege4
	 5Xe1w7JVI+h/PY+6NVsO7XyBmGwqMVzYRwesCK5D9JGBdejXXKM+fPbvzmi6WZzt6WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657293;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pvrxCavEY1oK9h13zUKSYsDKsO/+0N+t+Jn7Dea1vaM=;
	b=uE8VnGOu3ecNcWLHAVWmcKxjw7d1KRJojhm640NehjIOmKSOvRjBpWwgZep9Hh3GTZaw
	 2ztAhLwH/mA8mQb1Qx/gd81dDAVvY+Jdg//BPV2N5pMUmlyTiep1T0gPGtt2v6EhYXL+D
	 yQftcCYFlgAPclMewXZ/kafaVDf+KgAqimGcI/15Dboabu82f9ZShnvQ4+jVMBS/QiN0I
	 eE2DTFxkQprE5g+ufWKKIqFc1bq4oxjgYAEcFRvbVeORG+4+1hANdXhURIjDU2NTN73KK
	 bAsA1EwVPIRbjomP6m6uqIIXtwtCgHM6EwgmRsbpKUPCU7n3DT5IfqjR6bErqBEdevg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="fpo/gXkw";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="e6G8/Ld4";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710D606A324
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E710D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpo/gXkw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e6G8/Ld4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792657291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvrxCavEY1oK9h13zUKSYsDKsO/+0N+t+Jn7Dea1vaM=;
	b=fpo/gXkwpHnceoN0YqdrnxXPOvBOlZcd4tuMLPd2Aulif1BvmTtnyrOeZXN7iBohQmhaDB
	tcUuFnpaRE2tJAYRteZ3Tb0jV9g43KPX0r3EMPrnhagD/Q6t/oXOAFqTtlvwNpujwDO759
	Z6N85Hc9XtncYB0WnsMDvFpPs9zX5QI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-jKDeIXkIO3S3qic6wovTxg-1; Thu, 22 Oct 2026 08:21:30 +0000
X-MC-Unique: jKDeIXkIO3S3qic6wovTxg-1
X-Mimecast-MFC-AGG-ID: jKDeIXkIO3S3qic6wovTxg_1792657289
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df730c035so1158054f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792657289; x=1793262089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvrxCavEY1oK9h13zUKSYsDKsO/+0N+t+Jn7Dea1vaM=;
        b=e6G8/Ld40mBFHN6wkaFnucPgT/0nfcX1O7J0656rPMdwmHvL3lYiEB6jj/UrjcJvoh
         FrVZ0HycPJTaQtpNXpgW2r+9Iyxefif1/L8tGXVoOEzav1MOQp71P8+GRgO+hP70Mq41
         19YnSM8vhEF99q+zs/VKLTeh0FACvGROkQ7O7M7zfa6McONuHsU5UNcAmZhfBj/A6kxW
         cai+wMq7V/L5wZveCccJWM9TLwvJOEg4WFTpxpSvoGiRZv6t66Nd6vQJ6J9C1ar5Szay
         404eNxFvUL3OtzYhPZJsaqet+jqKgw/XsQnJ2yAj++9OoBev8IdT8kwZXA8Los8ZWfpX
         JdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792657289; x=1793262089;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvrxCavEY1oK9h13zUKSYsDKsO/+0N+t+Jn7Dea1vaM=;
        b=msItG9MkDnrXsHAWQWVljuVpt+c5yOOF28ijjFVeA8yXXaSHYQpZFthL++2f8nMXJZ
         KLH12GH7lv69T9JH6LaGkLoavolTnd4Qf3yZHUCsA3RPSCKuJw4INhmxkCob92q0OOiS
         AFqkEH1UCBpe2ZOAifw4G49Mk5HH1H35wPQL+LG/wcFsqQU7w/yIJLDZs8sK2vEB37NI
         NA0lTYk9USgc1XWab7/+wBCVBGdfOaH/FE+YuqvYALyi/5J0PHnkFvLl9TB6bnpwKxR4
         Eh8ymhqQpmwT0wp6vatvf2sXO8tulNhK1QDN0PStxDdO/JVzsN/XPg7sQDLJdQ38Y7uN
         UGxw==
X-Forwarded-Encrypted: i=1; AKwUvBxM2r1kC7mZa72MRaaipAaYfShF/BhN3bugfME+bXaiFKPYQIbjP+c3eg55zSwcKemgjTE7PRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg3Mlhc0MKkS00lfAIED5H8TFuvWnT4/D5Ce8koPIm7KjLrTo4
	1zjt/5pjZtWtpaL/xho4X9gVSyQzZp+UHHqTDWMNU4W1aTkQptLrzfBM8c5pKD/EZvqESrc8wBv
	HxNgdA3fL5W8ZSrGyC/hSCwiprRK1Mez6kKQ1cb+OJgpE2WctcJIbCMgQYA==
X-Gm-Gg: AYBFou3Cc82GU42zLL4OSIn7xeRILT4QYRmt8O7ZTNfxisuUbaXt+GFEAUTWVWJYHSb
	XbI7zsKHyhYpxRaO0yhfTQIr/Iv6ey4iyfPrapW9M1+fQzY7sYs7zZr7m3dhxDeN9EumnLgS6sh
	tTleQHsyvwFhqXAYMeWCd//6zCgFppu+NjtjsYxfO3LBvgPPHGFRoDI9emcUCnNXyCyBI6lRmHM
	Bkjfe9yX7rovKVRuV0Cmj/Zc8oOaNkXr7E+m5RWWAOLTYzh68wY2Haq48YJOYCYIk2X4CQl19Ya
	qMXsBFFDakkGvfzy11a44ZilY3Qt2gyidApPGVtPUW2jQ2vySnyuf2YRWuvbzrOnQ7101OwFm9p
	bOgNZ8kih3/kr7oJ+vATxP+3YGJHi0lU4Kk1IoRFVZ6gLYf5Zy844X2ISU/lJIS2IUbx30azjcg
	==
X-Received: by 2002:a05:6000:25c3:b0:48c:43a3:6a74 with SMTP id ffacd0b85a97d-48e2649d874mr10773774f8f.12.1792657289367;
        Thu, 22 Oct 2026 01:21:29 -0700 (PDT)
X-Received: by 2002:a05:6000:25c3:b0:48c:43a3:6a74 with SMTP id ffacd0b85a97d-48e2649d874mr10773718f8f.12.1792657288926;
        Thu, 22 Oct 2026 01:21:28 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f15esm11704149f8f.20.2026.10.22.01.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 01:21:28 -0700 (PDT)
Message-ID: <717ace2e-18b2-4df5-848d-5757c01ee5de@redhat.com>
Date: Thu, 22 Oct 2026 10:21:26 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/15] net: skbuff: make
 skb_copy_and_csum_bits() report unreadable frags
To: Josef Bacik <josef@toxicpanda.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Mina Almasry <almasrymina@google.com>,
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
 <20261021-b4-skbuff-bug-on-followups-v2-1-2aa780a03524@toxicpanda.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-1-2aa780a03524@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 15:46, Josef Bacik wrote:
> skb_copy_and_csum_bits() has no way to fail.  When it reaches
> unreadable frags it zero-fills the rest of the buffer and returns 0,
> and since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
> skb_copy_and_csum_bits()") that 0 is the correct checksum for what's in
> the buffer.  Its callers can't tell the copy didn't happen.
> 
> That matters in the !sg && !csum branch of skb_segment().  A devmem TCP
> skb keeps its whole payload in unreadable frags, so every segment ends
> up with a payload of zeroes, tcp_gso_segment() writes a valid TCP
> checksum over it, and the peer accepts the zeroes as stream data.  This
> is reachable when both SG and TX checksum offload are turned off on a
> device used for devmem TX: sk_setup_caps() still gives TCP SG and
> HW_CSUM, so the dmabuf send is accepted, validate_xmit_unreadable_skb()
> lets the skb through for a NETMEM_TX_NO_DMA device or a matching
> binding, and software GSO segments it with neither feature.  Before
> that commit the segments carried uninitialized memory with a checksum
> that almost never matched.
> 
> This was reproduced with a test module rather than on devmem hardware:
> skb_segment() on a TCPv4 GSO skb with 3000 bytes of payload in a page
> frag marked unreadable, with features == 0, returns 3 segments whose
> payloads are all zeroes, each with a checksum of 0, which is correct for
> zeroes.  There's no warning or error; the data is silently replaced.
> With this patch skb_segment() returns -EFAULT.
> 
> Make skb_copy_and_csum_bits() return 0 or -EFAULT and hand the checksum
> back through a pointer, and make it __must_check so a new caller can't
> ignore the failure.  Running out of skb before @len returns -EFAULT
> too; commit 417261779eab ("net: skbuff: don't BUG() on leftover length
> in skb_copy_and_csum_bits()") made that a zero-fill and a checksum of 0.
> Each caller takes the error path it already has for a failed copy:
> 
>   - skb_segment() fails the segmentation, as the csum branch already
>     does when skb_copy_bits() fails.
>   - icmp_glue_bits() and icmpv6_getfrag() return the error, so the ICMP
>     error isn't sent.
>   - __ip_append_data() and __ip6_append_data() drop the new skb and
>     return -EFAULT, as they do when getfrag fails.
>   - vnet_skb_shape() fails the same way it does when its skb_copy_bits()
>     call fails.
>   - xdr_skb_read_bits() returns 0 without consuming anything, as it does
>     when skb_copy_bits() fails, so desc.count stays non-zero and
>     csum_partial_copy_to_xdr() fails.  csum_partial_copy_to_xdr() used
>     to checksum the bytes it hadn't copied before checking desc.count.
>     desc.offset and desc.count always add up to skb->len, so that only
>     ran when it was about to fail anyway, and on an unreadable skb
>     skb_checksum() would WARN.  Drop it.
>   - skb_copy_and_csum_dev() can't return an error, so it leaves the
>     checksum alone and the frame goes out with a bad one.  Its callers
>     are drivers that never see unreadable skbs anyway.
> 
> The zero-fill stays, so a caller that does send the buffer still
> doesn't leak anything.
> 
> This was found by the Sashiko AI review of that commit, and
> Mina suggested reporting the error from the helper rather than checking
> for unreadable frags in skb_segment().
> 
> Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   drivers/net/ethernet/sun/sunvnet_common.c | 10 +++--
>   include/linux/skbuff.h                    |  4 +-
>   net/core/skbuff.c                         | 63 +++++++++++++++++++++----------
>   net/ipv4/icmp.c                           |  9 +++--
>   net/ipv4/ip_output.c                      | 11 ++++--
>   net/ipv6/icmp.c                           |  7 +++-
>   net/ipv6/ip6_output.c                     | 11 ++++--
>   net/sunrpc/socklib.c                      |  9 ++---
>   8 files changed, 83 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
> index 5cca95869052..4f229fcecc32 100644
> --- a/drivers/net/ethernet/sun/sunvnet_common.c
> +++ b/drivers/net/ethernet/sun/sunvnet_common.c
> @@ -1167,9 +1167,13 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
>   
>   			/* copy the rest, with csum calculation */
>   			*(__sum16 *)(skb->data + offset) = 0;
> -			csum = skb_copy_and_csum_bits(skb, start,
> -						      nskb->data + start,
> -						      skb->len - start);
> +			if (skb_copy_and_csum_bits(skb, start,
> +						   nskb->data + start,
> +						   skb->len - start, &csum)) {

Recently Eric did some work to remove return arguments from the fast-path,
as with some config it gives measurable overhead. See commit
a02a765bd5c2ae7705144829b2911c96c29db6ba.

S/W csum should not be the fastest path, but AFAICS the UDP output path
could use it when building the aggregate segments.

I'm wondering using a 64 bit return value and encoding there both the csum
and the error coudl make sense.

Also currently net-next is closed for the merge window, and a bunch of
changes in this series looks more like cleanup than fixes. Cleanup will have
to wait for the end of the merge window, fixes can land at any time.

/P

