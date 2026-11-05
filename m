Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895189;
	b=msW8/l4msM9kt63pel+dhbsY0AXY/vA/T3ok2768FCSz9QNocVz2J3YtwdStKvOprKw4
	 Wq4UBAdPXKqmup5B9SSWHXVwXpFoNcRf6WqKgSBUO5/b5otsm3jVA7q//up/YzA/CrDUO
	 Y+TfVz6V3gkH0pngDIhe3XfPHStYghBMuoy6S3wwUVcQRrzxOLkrGJ4nDYmFW0nWoV/j4
	 OGdW2JzMOaxC48/Q7r1xghvD+4PnfVAM7ae8lnFF1SOj1bDjEmQPaElFTxtE8SXSCPO2H
	 xAPcQUiB7sTm3TUWbI2u6OSdbtjgmSWCpYFRshQv+0ekEwLETOSRKTUieP4V1/YEMQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SXzZ3mvZFMDqg5YgwjOalYO8n2Pq0CKWpID0C+MAkCs=;
	b=Oua+Oj8/mcGwh5Q1OBwkho9N5wUJrKqfwGGKTtUaO0wQub/8nOb7j7v2xGYlRYJTCG/W
	 w45AjwSVcqclwuiO6Q+MD4K6mPqZm+1LkbGjLY1uDpcaxtfg/roMIVBe04Fe0lccBObYy
	 uxjHJpCjnEPC5/XMoq6QOUAc2a9pEUZVcoBoqMLvpNRTet+YiNr2es+r7NvVkKdhl8HCc
	 DNuHnxZEI8bebnd7TFCIhjol7IXJOQW/xoWB8w3bz64FDSqjgWL9+L7iVELFsW45KYR9h
	 dUcdnfUQgZCp5oaTo+4X1JNzFlPHniXL57mONRTsrX4lenBXpJ6opfyTOeEg09FvzVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEObDc4I;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC29606A333
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC29606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEObDc4I
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so890881f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793895187; x=1794499987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXzZ3mvZFMDqg5YgwjOalYO8n2Pq0CKWpID0C+MAkCs=;
        b=KEObDc4IpHPc7qgwJS7dnq9eEA5+9zRyNJOcQ9/aajIhZ3ZInqwQR9heMuVmpMi78V
         4DI2qJgVA1ZRDoa7pKHx8dl7aFyE2hxNLCzVz4jtqcX0UDZCjpJsLKHEoOpbXXrYs+F0
         3JP1hiIAiJ3r1z6zdTeCsefuA8kNLR2fwm30Q+y/A6uTfKn5/mzfByVbxJB++azX0sPY
         W+43gIYTdWpwewRT8SMiqvCypHfAEARMOYGpG45wBS5f+TSwBwmKMU6yx1Bz2A+GcAWP
         itcFE4IHajRO2LnSbLUF6cM8vdgBcLBCshAI4ghytsoFn8Swj5+XqAkrzbhOod2PxR8c
         woXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793895187; x=1794499987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXzZ3mvZFMDqg5YgwjOalYO8n2Pq0CKWpID0C+MAkCs=;
        b=az7AbaYwcy+N1TzYZt18wyWC7FyO+vMaJoLwT0ZYQyMCk+VQsCn5wUv30Y4oWqNuT2
         dmymId2tnL2HwZVe0X0gYE8amd2Nqhoxrb6PTtb5oRUIzaxD6sleRK/2m6uUdieMo3q4
         BydXWrN4oled0c3knsfzWcqMNzVw8gbiYCsCBBLvfs1TXFaDkAaMZT62R/LOhzLpxeDR
         BU02R3vZPzHMJT3oGmIOT7Zy27mcOKmtCyRttN9RvW2gvbdR0QOtNCcALA6h27mpssOZ
         AxY6A5JlRDo63jWl9W8sHfciIywgoPirslWMyAQDFbr8jcZ63t+mWMpxEYYlZ07uCMLV
         jfow==
X-Gm-Message-State: APuU4Z/8kgfyt8fWc/8lbKLnvCqm+F+1P/wxg587e9GBqZ7wgjuLtavD
	w3zJgA0FQuAxMcfq1iIL/zNfFyTtSQwjkyROPgMtrm9gaxr1Wtk+I+ax
X-Gm-Gg: AYBFou0sx/C02Gz8EVOb0b4LGzsSSsgjlRlP1BRpihOIisxV5LDvVClMUp7cDXTKkXj
	BiXtGW++z5oxtQI5mtf4LkDrxdTzBV4yVeD5V5lS5Utntfxa58hXdkCg45olF3gpoNayyTP01Fy
	+nQ84DvmlIqk3d/9kAgOWRAtx6/0qawDhIPaJoQHu0GuRmXK9PqV0BMBC5i9XjEllMf8O3wLEE1
	quKT9ZVQtPaYfllJ86Rtk2yqT51fd14Eq5vuzBZh+qQ4yaV1n1uG4B9JHiLwFKEmKa6SB1+bGHS
	P38tFchQZraU7cSk13PksD6IksUQ3vUeFE4xX/1elYcxZBYpBlwNKnReUisazqHDCYjTcDFDaoK
	t62PqSuk2m98DokYjoFqJhHeOdQXLz3vp/kg4r/7zfLt7+ZwKiHpTK1UgIIJGiaZWF6rnR2fytQ
	gQoUSSVUjTH7umDnQNeCm1IFH3uVcdbZ1Ui6eRnJRG+c831cu7qQrgzNq0bk6+CiFWGlMmlPVuT
	1mA6GLbiEpGd9y0I+9F9ILBnURuywQBgCpD6D7k9juZKYgeLBA98D8tunlp8mLQusZwGJ34WTs7
	PiunkFoWvzBEqDOqF0GnJDuOvI6Bq6c100r9KMi3ubF9OhkcLwW1d9FXetRgp3hs85iYHkUfhyV
	7Kd4=
X-Received: by 2002:a05:600c:314a:b0:4a2:fd2:985d with SMTP id 5b1f17b1804b1-4ac1775316amr412873885e9.12.1793895186807;
        Thu, 05 Nov 2026 08:13:06 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:f9f4:f942:71f:df24? ([2a02:a03f:a75e:9a00:f9f4:f942:71f:df24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feeb51a9csm11356024f8f.59.2026.11.05.08.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:13:06 -0800 (PST)
Message-ID: <2a63b050-ad39-4a32-ba68-4c9151dcfd15@gmail.com>
Date: Thu, 5 Nov 2026 17:13:05 +0100
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
Subject: Re: [PATCH net v2] ipv6: ioam6: do not modify shared tuninfo
 eh.nexthdr
To: Hangbin Liu <hangbin.liu@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>, Sashiko <netdev-bot+sashiko@kernel.org>
References: <20261105-ipv6_ioam_lock-v2-1-8f0ea30c4ffa@kylinos.cn>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20261105-ipv6_ioam_lock-v2-1-8f0ea30c4ffa@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 10:34, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> ioam6_do_inline() and ioam6_do_encap() stored the next header into
> the shared ilwt->tuninfo template and then memcpy()ed it into the
> skb. The lwtstate is used from multiple CPUs without locking, so
> another packet can overwrite eh.nexthdr between the store and the
> memcpy.
> 
> The packet can then leave with an HBH nexthdr that does not match its
> payload (e.g. TCP labelled as UDP, or a local packet labelled
> IPPROTO_IPV6). Set nexthdr on the per-packet Hop-by-Hop copy after
> memcpy instead, leave the shared template read-only.
> 
> Fixes: 3edede08ff37 ("ipv6: ioam: Support for IOAM injection with lwtunnels")
> Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://lore.kernel.org/netdev/179336082844.3134.1265197633714491521@kernel.org
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
> The issue is reported by Sashiko. It was confirmed with concurrent TCP
> and UDP traffic through a shared ioam6 inline route on a multi-CPU host.
> 
> Without the fix, a packet can leave with an HBH nexthdr that does not
> match its payload (e.g. hbh->nexthdr=17 with a TCP segment after the HBH,
> or hbh->nexthdr=6 with a UDP segment). With the fix, the same load reports
> no HBH/L4 mismatch: nexthdr is written only on the per-packet Hop-by-Hop
> header after memcpy, never on the shared tuninfo template.
> ---
> Changes in v2:
> - Add one missed Fixes tag. No code change.
> - Link to v1: https://patch.msgid.link/20261104-ipv6_ioam_lock-v1-1-4f24c41b261b@kylinos.cn
> ---
>   net/ipv6/ioam6_iptunnel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index cfb2c41634a0..b23f8a0cbaa9 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -276,12 +276,12 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
>   
>   	hdr = ipv6_hdr(skb);
>   	memmove(hdr, oldhdr, sizeof(*oldhdr));
> -	tuninfo->eh.nexthdr = hdr->nexthdr;
>   
>   	skb_set_transport_header(skb, sizeof(*hdr));
>   	skb_postpush_rcsum(skb, hdr, sizeof(*hdr) + hdrlen);
>   
>   	memcpy(skb_transport_header(skb), (u8 *)tuninfo, hdrlen);
> +	((struct ipv6_opt_hdr *)skb_transport_header(skb))->nexthdr = hdr->nexthdr;
>   
>   	hdr->nexthdr = NEXTHDR_HOP;
>   	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
> @@ -314,8 +314,8 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>   	skb_mac_header_rebuild(skb);
>   	skb_set_transport_header(skb, sizeof(*hdr));
>   
> -	tuninfo->eh.nexthdr = NEXTHDR_IPV6;
>   	memcpy(skb_transport_header(skb), (u8 *)tuninfo, hdrlen);
> +	((struct ipv6_opt_hdr *)skb_transport_header(skb))->nexthdr = NEXTHDR_IPV6;
>   
>   	hdr = ipv6_hdr(skb);
>   	memcpy(hdr, inner_hdr, sizeof(*hdr));

Thanks, Hangbin. This is a fix I had in my queue but failed to send it 
due to a lack of time. LGTM, except a small change worth adding in a v3: 
consider making tuninfo as const now that it's not modified anymore. Let 
me add my review tag for v3 already:

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
