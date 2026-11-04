Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757883;
	b=1J32T2NSReCRsQuUJMyWXp7t1//HxPjNTp8PQicS4ml38PuzReEPoEsqniFDtiuNBWJg
	 AfvPTxaXarOUbh8UOQ/4xBmDqFqj8y+QPdwnNSIzoP3wZW46csnvDzLe1m7b54QK0CSls
	 4owSqTzRdlXcpsoGbfnScpJhWsntw2mBz0zYq8vjbYlHPVYTeaVsdJZYPXH7dKpMgiX7L
	 rj7DjABzkgjckn9Hjn+S8yU2/xsWEJvrpPQY2YXxixMpgf/CvFkD3IS3cWawSL171UMtn
	 I0FLan0wRnCDDEyDbd1goR8fKX1tbtA9IjchzGgzRwWyeH02ODjjiz9iWvZRqvxRPSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
	b=KZANOh573rdIVulhVDmdfaxJv4idQOBX/ovqSWjhq32ej893rw00PBT2GuzKRtw1q+bJ
	 DKLXLf9MVvRZqdCJobCvlGqE+GhueMHcpM1iXQ06m3Y3qc7+SPND9KEFqzAJKcHP4da3C
	 oXLWyg6/GP8IKi4jzmqEyRrRtk380JYlOoCNZNGb6/eSuTmSs68Oc0Oo8zYP1F5b3WzVb
	 /gditmWx1FRbetcPnErx56uazyYrsDZiBW1UKDN9nWPDEWWj5YGZ8lv1718Iqv81EmAoU
	 uB/vKCIRLoJrD5niWpYuM3k1soaKU+lYLl5vny7AhEmylVkAl6xpA5nmtSSmkbDu4CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkMqmVb+;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC06606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC06606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkMqmVb+
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e96502e447so1449705ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793757882; x=1794362682; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
        b=IkMqmVb+s7eQXz9CRvobFAuhMp454C/jf+ZIpYugWSUX8QxHFjn8nf5QeJtQO9OSGB
         57QeCNwuigRQgzjCPjjJ4XfQnBiphfCdDiwMjAtOhUdJ17e9VAFRZZSdwbos1/UwYqth
         4tUHXGaJz7XgeC00BldzMMa+mCtV7r46X4WOMOHAMsg3qVMLWzDa9wWTMgYEQNiukexy
         qL+OZcDmCjTVgftVHFtL/axcExcDwglF7mKlVdjYlHk454YgBWJNTQfmGWuPX8Q5XWca
         pmIcTokqfn11vp50ZxY6fpgpvWfYAq46HkTSzIp3HPQt4QtHmNaNp5n1JXmY+bTOhbiW
         dbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793757882; x=1794362682;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
        b=wxxtbODml4tz6guqMP2uIAU/U7dmO9XB/uYpNodtv8XdQz2xhu8aVIuz+N4d2MwZnN
         l+MLglIDfQ+eXfbdLAPMrACXbWn21nEPxa3WgQ7sbKrOmW5fRHaf8bm68ViJZX3toThp
         U4nep/yO+e4bX46vhlL4zmjafBV331X6O4sYQRTAwizucDwhn612HtTChjwAr23CD565
         IhKr1Y6T5NPApna7PceoN1CTAh1LspCRCbj4cGDpeyEYEMxHxEO/A6GQ0qDW20SUL+oJ
         UNJI5zJqDb4ekacGhxiMnldsJniCZ4lIcxlFbDy0UGSRRmlH0NtXuyt3/RAfVHaiYuET
         NuDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJtCGn0ij1o75icRVat3Uim2SKi198+Xp2jjyXFNmEMiQl2S8cMj2kcb6l4plS697QznCc8tM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+k5RFSmPb4VdzXRLE8qogbwISHzlv2jYsoQc5rngdQEt2NOs+q
	S3Ze3R4GOG2w0TbfgPnmVMu+RIjJ3DZBNyd1j3+JzrS/2Fh3xm8OOqz3
X-Gm-Gg: AYBFou135jCL+SPeq+0iZ42ANwnAp9Lp3m0E1/kizvi2Ybhs54KdIsSJzc+DaO2MqxL
	tKhDDNHCRocLf6Q/Ph1nc3FSn4dipkBgX57iVb1U1Hhd1LXJ7wOmO3j8Er1cPn+9sJjYQH/Lyf4
	ztqXB12XFBfGpkBP27cGQtHMRe2A2sySL6mk1B3xRHJ56xYVdLkgd7pdZBYoiJznzW/iY0KgMAa
	kcXp1oGsIhvXTTMSgULQCtBFkcvcOJWoc/K0Bo5T3rs0s+FA0JHKrwTcynslZJ3nG4TsNgGiwEl
	xMYb5K02QJthiLOG3NrWlmsoSzYodNdH+0nGwyYQIDazZIIL5fFP5ye6YnKrnKjMmG+wKr347YD
	V5927OuRRHYHLpCk69s7Zda3kTjVMd6Tkep5HGoTHL/3HGoo92mzlUb+4STLnF9Aurl0TVkAu87
	Fy/XFVhQst+Pyd1EuY/W2NJPVun8ak4f9uQC0bVKj1TGigHMDxNhtUvZPgOUe8mWhCux13lXvr2
	oCAE1sF8WPHRNaZ3pC7d1VNE4FrtRTHQxHgZp+4ZqbqcdW86YYGV+2aE9DySRWfy1K/MVZxGYcg
	E7fY3PvHHwuvPNLf8Sv8rS7FoZ9w6ZSE7gEmVTiAmcg31qrPOscUh0PEiS3Gd6jUWdG1/DirTvl
	CA1BKLS6QxVY4LbMLAdjoeQ0XinM0xwslgg==
X-Received: by 2002:a17:90b:48d0:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3ae8983c697mr11675852a91.43.1793757882013;
        Tue, 03 Nov 2026 18:04:42 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944bb7d0sm1356275a91.11.2026.11.03.18.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:04:41 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:04:40 +0000
Message-Id: <DMM23MFOQ7ZL.3P1ZUMR0MKVEM@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <davem@davemloft.net>,
 <edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <kuniyu@google.com>, <willemb@google.com>,
 <matttbe@kernel.org>, <mptcp@lists.linux.dev>, <mason@kernel.org>,
 <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <netdev-bot+sashiko@kernel.org>
In-Reply-To: <4d3b8639-a313-444b-831a-f1f069882b86@linux.dev>
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <179374187706.488855.8366350890804573396@kernel.org> <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com> <4d3b8639-a313-444b-831a-f1f069882b86@linux.dev>
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

On Tue, Nov 03, 2026 at 05:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> The log of patch 13 says that a cork is not safe for two senders.
>> Jiayuan proposed to serialize the senders in the reply to that patch.
>
>
> I will pick up thoes pre-existing issues and organize others reported by sashiko.

Thanks, but make sure to create reproducers for all sashiko findings.
Most of them are wrong.

I'm waiting for netdev maintainers to ack net/core/ bits.
