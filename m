Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792855592;
	b=CfUg1sCKkMnPMqsEqa8XHo9Pfe1g95iaJDLw96HZBhWLCMXv+NVkF9oWn1YRM/u6pDq+
	 6ubQTnSLj9uQoaL6gIv26O3IWN6ZSD1L5LWkIwieVXfbe9yi0D0LOZ7FlYfqatg07brOb
	 Czdh0D3X+TQHlEheqdbnNpz9BpC39IDGZbI9YyXA46jvdXnqoDaiPnqhj6ACjDK1BAjjU
	 ym332z6WgGGGzk0uw/yr0cy39UyN74GpIZDVlkf5VHQwoyLwnvawMnXOQCm0pZsj3UlLt
	 iU8Jr87k+xYxFNxowjzRXJK6m+fO9A7STlfMqiYNDioL1jTRo7Uo3BSfvGQIGIr1ZtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xcKJrThSQkTRcWQqp1bzIYcpjy9U5zg8jr3P10/bJNE=;
	b=JpiDSPuH6pPvKisrqbMb1lqXX40ORmIgoIE/w29AqEci1NujM3dMBhqUALVPXFu3/2lh
	 Gn5i03AovWuIuw81V6HpNUfBe++jDu0VqRYlEAwdDLE9CNRADityAaeudPBDv7P0GxpJ6
	 8lQOgXO4WIc4opEAyT7YnamFxilou73ca9yoMA1gwjgN3YRs6lftjY3hvzrmUjLtxyrQD
	 2VgGet0v8k7V67XvTGmij5Z9WkXaCMA1sTXB9rsESFcXCVHEZAscLKtT9p+vc8NOQldqZ
	 HN8FdhR6b/v8YH50ukGMWChGrDOid04BmXCpOMOPxYg4QvqmUldgRHDgXiE8m5OJYBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qMIzdSxC;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8D606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D8D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qMIzdSxC
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so10351895e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855590; x=1793460390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xcKJrThSQkTRcWQqp1bzIYcpjy9U5zg8jr3P10/bJNE=;
        b=qMIzdSxCyph8HAv3fl8sH6g2tBwZeImD0xSsZRAR9V80rJAeHoSJTFaGWPb8kz9OUj
         G3UVN5s9qE1ooH9Uj31voL+oRvykTFrcPnab3Efr5cNsuFMUpOCEO5wKGo37AlZozIqU
         /7nA9rxp3FjA7bNlfa5V3uGiICXXgbEkVUHD+aAFkS2S3/hB1YRua0PJQ/UxdOBxW+lu
         kguVm7q/K4PPtr3y8GH/Nz16RtGlagsPWYD6/ktjPS9/JU5IZVYpdEL8Z297GbXHLNzh
         TfpQei1l7KBK/FqQJH3k86ZnS8jds1zogfbT8ZnX4unH7qaxBm32PGWUZ3iCIsMCdAQj
         VDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855590; x=1793460390;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcKJrThSQkTRcWQqp1bzIYcpjy9U5zg8jr3P10/bJNE=;
        b=XnCH4A9x33pRNlkS9Gx9FvGo7KjpQF43FDiJTCRaxt43HVSmwWu8bIPSWsajBy7q+q
         FxNfgu9+TbUFFrXxkDkLzwRQGGJeq5QzSyVh6SwFTd5wH18x9riCdDTpGo9kc6IsvTFm
         XvgqGbEjWLqjwAJQAi4P0l5Rk6SGXdNEOwvaj2xhYE6+v15VD1GKGkIdPh6/j0cRqi2w
         FiQPGw4dZz+HfKJTA8D3FPkdOxutdLu42Tf+ZO5vjlVgsUkQS1T8EaGO6xs+lge0YT9C
         glOq2uqh4wkj0XCv8hEBe/NitMOG8clJP6W7sYdaK0TjKZJO5JrfpjaNN3UbHaO/Jq7G
         KjSw==
X-Forwarded-Encrypted: i=1; AKwUvBx1ni9THG0+LWRrdpVDnfMfz9ffDZ2ewsgwUgu/2gsyNmJo8JkwJFTGlHWyiQJltl6vdsqO9Iw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8b9KP2l830G1eV8mkDj3F+67Y5Xbs8YXsI6+aLC9iOInpt9O7
	Thd9kkWY/HyDDcZeYikXe5oL4NHwgz1Abdl0CPazeyIt4QA3nWs3fUKcqX/XUg==
X-Gm-Gg: AYBFou0gLh80F9J3s1NlnnfoablXcLtqZnyL5Mfa+tJgHs3TNjVuggI/WRvIuKERtx5
	rgi76D/JTARAQ45ZoYX7OuiHb+ckAaovuIVlf1Y0q2X4eXDOOAI/i3aYX5L/iP22Xb/kj3H1YXQ
	Rj63vKrXOmIG0/+KVEHhytvlLrUHaMOjy0MMHSNNMkNtYSN3eFFjaQyQ6stE1PUbtytUoqqt4bV
	c3RQPdicKWqKOjjnqaZZt1KIcDoKMpXjcma/7dL4NltzIMbTeF3I6FXuL7ALCZwzODaPP7q7jbf
	WDvKB8uTVcgwJqrf76Wxi5VZSXe3oX33N6FbI966FrGEYv6vITk1VS0gzUHOgkINT+PkPHjWVCe
	OJaI6ENKaaccS/MrZyVMrWTZfQ/Fdor5//oj0H95OzPMetE43JMOu1mlELHlwg3ozQC3cFTkgAy
	kW9XoTMWiombuMherB7Z61Ag+UTdVncf/QhJ7a0ZHWVk2bFyqBZfmGzILksHhvtAvUsaIYHA1ln
	vjjL8rSTuS++P4hPQqNAh1MuxSL2725kAFzjVm3jAFMjahkUVpgjVqvMsDrM3hhqFGs7Cmc1vfc
	7pSpZ89G/oNSHSHJESGR9XVMHvCaf8kno9c=
X-Received: by 2002:a05:600c:a45:b0:4a1:e11f:b2e1 with SMTP id 5b1f17b1804b1-4a35aca4bbbmr39295455e9.15.1792855589800;
        Sat, 24 Oct 2026 08:26:29 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5f89:9b8e:8b05:a501? ([2a02:a03f:a75e:9a00:5f89:9b8e:8b05:a501])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f3e00asm115074635e9.0.2026.10.24.08.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 08:26:29 -0700 (PDT)
Message-ID: <1d0887eb-2ce1-4768-a1ee-6c05a0830f52@gmail.com>
Date: Sat, 24 Oct 2026 17:26:28 +0200
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
Subject: Re: [PATCH iproute2-next] lwt: ioam6: allow options in any order
To: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20261022-ioam_fix_order-v1-1-6eac1e00455b@kylinos.cn>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20261022-ioam_fix_order-v1-1-6eac1e00455b@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 04:53, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> The ioam6 encap options must be given in a fixed order (freq, mode,
> tunsrc, tundst, trace, prealloc, type, ns, size). If a user uses a
> different order, the command fails with a misleading error even
> though every option is present:
> 
>    # ip -6 route change 2001:db8:2:1::/64 encap ioam6 mode encap \
>        trace prealloc tundst 2001:db8:2:1::2 type 0x800000 ns 0 size 12 \
>        via 2001:db8:1::3 dev dummy0
>    Error: argument "tundst" is required
> 
> Parse all options in a single while loop instead, then run the
> cross-option and missing-argument checks after the loop, reporting
> the missing arguments in the order the options are documented in
> ip-route(8).

The current order is not arbitrary by intent:

1. freq
2. mode
3. tunsrc
4. tundst
5. trace
6. prealloc
7. type|ns|size

While I agree some could be swappable and the above order is too strict, 
most are dependent on context (i.e., a previous keyword). For example, 
(type|ns|size) are only valid in a 'prealloc' context, which one is only 
valid in a 'trace' context. They form a group and their current order 
should remain inside this group.

OTOH, as mentioned, some could be swapped. For example, both tunsrc and 
tundst could come in whatever order. However, they are only valid in a 
specific 'mode' context, so they should appear after it. With 'mode', 
they form another group. 'freq' forms another group by itself.

So, I guess a new accepted (relaxed) order should accept groups in 
whatever order, but the order inside a same group should remain. That 
said, I'd be open to this proposal if other iproute2 commands also 
accept parameters in any order, regardless of their scope or dependencies.

Justin
