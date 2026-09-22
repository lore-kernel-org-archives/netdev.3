Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5585349DE
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072615; cv=none; b=g4bJULiB7fIW54RlDK7b+S4S0+HEEAGdTEoWBS7BPvweuwyOXi9piZlyqnw+IugKnlHfUS60QmX8P5wi6sWxrEOUzG+fbrslpK5BxKTY+9ec5EAQS6EjhfXEGAEiaKsLDBne3rDyX9N7GO3hLTayzjonpr3yJC0ou+ZDJNh8Iuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072615; c=relaxed/simple;
	bh=pkRjLax3zzL81fegkKWM65x9n1sdWMbtEO8ZJd4dpd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF7Qq+i3ahPRBggfiV+PKeEIhcr01zjRprUfoDJNqUpQLqK7nzI3OSPBh8Q3HrtbOtHBqWjHUQDYgPvGxxvgeYW5hNj817adsywHxSaWEyLhUHlBn1Hjx5MytWguV4qov1M8LuXVw5RXLOadxSSVnqig8DRvPm5o+DhoF3esC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fm2+vrCk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOLKst/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fm2+vrCk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOLKst/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790072612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1CYMfDy8oUHGmL4D9db0zZo1jNjyFLIMfncfNhVlyk=;
	b=Fm2+vrCkIP24IR+mik5jWCD4vk7Ov3WtfwWMFPadEaJ2SRtSS/y6z7X72XWRaDh76HBiyb
	fUUQhqW0q2KzoNhoV8zF7kHT5ykgLfSRbNvsuhi0sa5DPlqydMggsdulYOBqTwwSzdVVrO
	05N8Yzg5JgvlaMRjU4KjFNkOX6s2oqU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-47JbJDlxOUi1EMjtadyM8Q-1; Tue, 22 Sep 2026 06:23:30 -0400
X-MC-Unique: 47JbJDlxOUi1EMjtadyM8Q-1
X-Mimecast-MFC-AGG-ID: 47JbJDlxOUi1EMjtadyM8Q_1790072610
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e65bee41aso6466695e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790072609; x=1790677409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1CYMfDy8oUHGmL4D9db0zZo1jNjyFLIMfncfNhVlyk=;
        b=OOLKst/sKdTUgUSr1BL+2Mr91fjyITqW7fi4BuoMLngFw80M5yHtuKK4gsKIzAFs9S
         bi7HmsTLRxx3S25DkqjYy8U3zPfa5vGQRrfYlcdsE+2a5BLKpvQSiIVysqTACWGKG6on
         t7eMlT8ke49aEaM/5IRAOuhpGbYY0OucqzxBYghOzohZHBIDH9vgXgKGvxI9j1Az9Mel
         SzvqW/7c05Dq8iaJAu15SmVGkC0jlmqBetJB2gUpE5zK8xu/u2hb840BmFCZbdsqzKNb
         wcslhjHz5b+XFm/6iy5Dt9tV6LgvCmPzAcWNLomXgxVcXNoVMdneNssKw7MZBu2fi+iO
         5/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790072609; x=1790677409;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1CYMfDy8oUHGmL4D9db0zZo1jNjyFLIMfncfNhVlyk=;
        b=pTNOE+iLFREdNTuFuztEZHQoXMVHNhjq4F5JXwKXokgj5tx3VXZhcBc6kC1Ugj0StF
         D2SKfjmvkn9GduRbdqxXYklmpXotfWFT4NWZdXcVneTQwE272fRzYPecPEZEDCET4k0H
         J9r/dtywnWypHG06179faHLQfmwQXeBZLmJ2niEvlQX0bLf0fMF/JaxKmmdnIv3vbiDA
         Xr8bGlcAJl9FtGCRKdW+A9Xbc84ItpZaWQ2/OYlzanNCDKbkRGuwYmRzLRTQkE43uOWQ
         RtAghbLopeKvKBZbt5rgFBpEnjX9us83r40ctN5/k7d2xGsZ62DMq9p/a200STPpGzH+
         PeBQ==
X-Forwarded-Encrypted: i=1; AKwUvByKhv8LGy4mDL0YayJapYSD655RdmLAUoPI9wxc+WShMwmLLdo4zdQIVUlaH3nzkvAelzDrJ/0=@vger.kernel.org
X-Gm-Message-State: AFuF++mNBL9Bg6xQUy6ctis/5KVfBsJdrDFKGqwUDSoR9PQcZyneSufk
	EXQwsqz9YmD1x9zG79p0u4q8pg9SEKFHAPVyT0tZDXLcDn6BT1E6x9cUxy5DykQlbAqpDjgYzDz
	/9XAWRfhbOYKEuVGRcPrFRIj867u1yljBuB1vdy+E2mitr45vSEOeOjfj6A==
X-Gm-Gg: AYBFou2Ye99P5W3NUKXpmCJFe5Hx/tMwCu2Rx1NsGxw8Yf5mBvLuXsEDegFWFutJKFj
	NS83pMTsbU79cODakialSzA56MXHHujYNl85Y3cqBsnyjvDxWgyKZB+vZREzci7hd5iSrJ3Apic
	YPSkZ3S3X3/sHx/cjjkUZrJgTC7Im93WekYpfyJ+XqL5QY6u9V2pYC7EqDcS1VhX1uu/9JV2Esi
	efqMB/FVL0xYImdc7Oj+G80SNdsG6awiNIBb8aySnRnkfTaJn7BE4Ix4FYJEF58Cr+wme2+h0k3
	0wsiNHKsdMxDDUIWgUgtU9odHNnDKWLGUGOmvmsGo9KAj+FuD8Hzzs7j/UHfaUqQiSO32PeIDiZ
	c6hn4gMwgwfIkp0TzK9KC+XVCCI2mICfC/YmML1jas+CBGONS6knboY1EoBiNc1i7oeyHgZ0UUA
	==
X-Received: by 2002:a05:600c:34c6:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fd88607e7mr39791275e9.5.1790072609599;
        Tue, 22 Sep 2026 03:23:29 -0700 (PDT)
X-Received: by 2002:a05:600c:34c6:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fd88607e7mr39790745e9.5.1790072609134;
        Tue, 22 Sep 2026 03:23:29 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaab0497sm48489045e9.3.2026.09.22.03.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 03:23:28 -0700 (PDT)
Message-ID: <a5fa376d-0826-4fdc-b99e-cc4a0a623cbc@redhat.com>
Date: Tue, 22 Sep 2026 12:23:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 0/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Kyle Switch <kyle.switch@motor-comm.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260917131441.3428554-1-kyle.switch@motor-comm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260917131441.3428554-1-kyle.switch@motor-comm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 15:14, Kyle Switch wrote:
> changes in v20:
> patch 1: Add phy-mode description in properties in
> 	 motorcomm,yt8824.yaml

At least some of the sashiko comments looks legit and
relevant to me.

Note that the cover letter must carry some brief relevant
description of the overall work.

/P

