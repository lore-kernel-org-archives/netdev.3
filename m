Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103511;
	b=s0mpcikuCs6iO8PDRiE9bsVYQMEKAxJOOiw2oFbAvFc86mpVbdzIgVd/GbjAdcczyvtt
	 /4+nxZFdLnhVXYkZGCcFae/lswPCwZVt7oGc7hjBl+VwUkLQaoQ0IhGhfHBbgsciyrP1d
	 yRw1LUiRUZhIgJiXWg13bmLJ3Al7kmcBRLji+Hwc5BcP806SLHBNXvzLoCznonQXEVwOA
	 0GEmJivfdHrfWbtiRUVhH0lDchrqIwiX8MkRerORCGR2uVLMfum8yET/lA2vmNnkfWr22
	 WSxLT+ol1YSxDGS68yC6CiGo4nplqAuo76n1kPJitbDuwh/QMXAU1mjHS+ee35q1+2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103511;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qm6TGibcwphKeohobyNtjyfRQPqYuyY51baxEc3sRXE=;
	b=Zm1cG3MtKp0uB9JTcntmrHrAVagXXzHGD9Zr3iwoZd3Y9H+U8uykN46fxOfhevsj9EMj
	 S5Q2AQqIrYWoqxhKlObeOWO+/SIeMH8W3elSNMMUo3bZTabj/YkL/Uj1ngAJMvTZAqIEt
	 V2TO1QBGD+gEhRC74SHtm4Y/vbTAFBrZVkotVhzDk4wo0nQUBos21cMuc4LlQFvZBmUo1
	 NUY9jfk5xZpPujQ/+FzPIUAcbDmtw4UyJzGyKacAJ/zbvoI2Gf3elj3lBsLp2SdkFURoT
	 GpDuC6hMcayGv/shab/F5ZtMefR2V3qvCq8HaQnkcHRx1n3jy2GuJmARSmqA3ILZz/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLv1f7FJ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pN7qsvxD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A99606A322
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A99606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLv1f7FJ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pN7qsvxD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793103509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qm6TGibcwphKeohobyNtjyfRQPqYuyY51baxEc3sRXE=;
	b=YLv1f7FJWs+KbmklJm81eSrtGXEzmnuuMcBMyviU4SOEI+Y3x2RDIVQ7llhVBz8vqT/AK2
	tLlkFGS0AOBta0OSWXT4YioZYFY2v3V1ANOwXX6kIcYud3zrprcGVs43y9fwlF/Z+wUOhn
	+aH0v/djRbHcVrQpbzPUoPeuvCvHxYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-RI8elxV0PYyFhl2BDXc3Tw-1; Tue, 27 Oct 2026 08:18:23 -0400
X-MC-Unique: RI8elxV0PYyFhl2BDXc3Tw-1
X-Mimecast-MFC-AGG-ID: RI8elxV0PYyFhl2BDXc3Tw_1793103502
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so27562465e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793103502; x=1793708302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qm6TGibcwphKeohobyNtjyfRQPqYuyY51baxEc3sRXE=;
        b=pN7qsvxDwVBeWI7RSLvEazYQHeVBSrlZNTFT/dMEBhhABu8gupbhwV1vnPc/GlVulO
         GFFVsj2FVx4D+sPfYVlZbUebtXt/+sB/J3YrReoHdiVE7zpLqIYeGowg1Zk5GLnwXRRV
         TvWYA/AwUIs5yztThams6vVpIQQGNIjWml6LHcJZ2oAESoj5XpRRX87oN7ahPo1rcs4C
         VWwVmDFmyFHmyWJ69xIlZcK9dVxHP1nYASavNijzvNSks5+TOJRZMhD3VTlDA9eSsHOn
         mLR2ZqIQZRjUDovQlWApAMjoECufC9VGXeKK6IYGWQ3mhidBv1DwEGhQxh/4cea/rI/Z
         OytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103502; x=1793708302;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qm6TGibcwphKeohobyNtjyfRQPqYuyY51baxEc3sRXE=;
        b=AxAwTNk3h795MLn+qHUQbFxridM7wljKcLxHgZGcnB8XbVS6hIDWAGMt67xKZBYRMy
         1XkbMzrptJ8NpSsfqS4kU/TZCFKlpZWGtfrkMvcr7Qvgi0NjA3i/UF6WXcDYPE0opShP
         5yX4bSkJ5KV0AGjuT+ZdXfEF/5fTD3Mcd/HXe4dWlPYcO8Y8My9FAgvqTMfRFX/xpl/b
         eWI4OulPAFfFxhxdOErse4evjaMCoxEgStdw8onFK9RjR1W5pm85mnkT17X8jn6Zf+c9
         j+uBIS+AffsW+HsnbrIbppHz8dsSjGXhr6L4amst3CSrQdFxgrFsjVAZaG6RiCWZ5hTu
         Q2XQ==
X-Gm-Message-State: AFq9FYILqw66rhDtIqRhChGoUEjJCmXsC6ocxgpejkDsEeNDAJ/R862o
	4GYYXQfAEJBwnXZiv50XTQKHQT/B+QMv3PvfogDLS6Sv30UsrIKTAcwdL4fPB3mMy7dHPH2dEft
	B/or2cdHN9+MamZ3OxCRp+99h9MYrile/5S29k6CKCGzWPYw42VD04ixBwA==
X-Gm-Gg: AYBFou3w5iPaA+hezLpM0tD6b245DvhxbPIERCxluzhmiqm0tzkdePhGoCtKqqObJNH
	E6R7ewWRz2rrUvLa1dRRVpMXUJjkOPYxumidUI+Q9vOO3Ug0/ZyF0sDDY4fHX3suvWusmTvlkMZ
	jmfdb1OOClIWGidYRBt4fN7U9p4uWeFFJ8o6a4gXSNatB3zSQFLrF6A+O8h2v7MECMoRoyBHHeY
	X9KR4/xNW70993n2gV2+h18HSpyS+ELogdNvHK5V/Xi394APJE9xmp+51bKSt3k+wOBhuPJPG0H
	uoPQ363G2Ib49GVdrWZNvPx0tqT0c+QXSgmAO1XOjNRXub4odsycjW9szZNs/TU2mzxtCVDj2S/
	XTV+VbRYAw8X7RXKkD4VYcMMCSIeVezeYNSpTrg0MqmYLi5y/HhdZMrU76pGy4dtcajmGScRCYA
	==
X-Received: by 2002:a05:600c:474a:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4a35ac91f2amr198363665e9.16.1793103502210;
        Tue, 27 Oct 2026 05:18:22 -0700 (PDT)
X-Received: by 2002:a05:600c:474a:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4a35ac91f2amr198363225e9.16.1793103501794;
        Tue, 27 Oct 2026 05:18:21 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm21785015f8f.43.2026.10.27.05.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:18:21 -0700 (PDT)
Message-ID: <cde7570c-50bb-4813-a461-04154d4cfa65@redhat.com>
Date: Tue, 27 Oct 2026 13:18:20 +0100
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
Subject: Re: [PATCH net] net: dsa: motorcomm: Fix function parameter types
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 netdev-bot+sinfo@kernel.org
References: <20261026083252.12684-1-mmyangfl@gmail.com>
 <179300378438.3327.666635400432470005@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179300378438.3327.666635400432470005@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/26 09:36, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
You should reply to the above questions here.

/P

