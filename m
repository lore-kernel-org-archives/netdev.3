Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240834027B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252152; cv=none; b=XQTtxsBdKOVH59dhby/ifbnAEs1Xs9jgc8zIiFkQyVDXISuK8MByNEkckNUlSO1u6cMp+F9/VNV9TZysAQesl9FlTOKMAvituTdRw/btn7BzvaIb2eaWZMfPdPBshtoOXa+qXRT+V1N4v4HupRKuhywiji+iZuHcYl+ffThN4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252152; c=relaxed/simple;
	bh=eMBr2fBmaaMxcZiLUlWpNuoMx2WqJMgvhgK3dO5Ta+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrdG+l+WFy7FCJeb6O75cZsAHdKDgnK2LJ+vhDOVx+utzOtv1KXyTC/mY4MvqfRCMmNCeLIWPK/wBC6XnF6W4+AeZIRNnu5uQzNZwWvwW58OrDWRKCDoSf7p41CuVroOCC9amoU7hd89+oYK/vcfgytouoqU01vR6pU9H4gKxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=UaFEU6WV; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="UaFEU6WV"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32dec843c37so3352122eec.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790252147; x=1790856947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fy5LuBsGPiW7O1O+BIyf1gvIblzkLkWCpfb1huUexVk=;
        b=UaFEU6WV4i2JTzX0J2LAbXq0l6hFjP355sT7WmPBPa6u22lw6MQ//c+aCa2h3WF9yA
         j8EpJHWbZ1OMzBXE/6qZ0E0wSTdSJIMkFt6ND7ixyNzaMWdKWBFbcajVmmqvBLIoLSQh
         3BTVCrsYWXGsXB16G4MM5w4YpqMqL4sV50qTCxRFbTZkLeW0yM4ckDH2kOrB0Ehzo9uX
         YcDpH+qIP9/kGFLAhBc2nLW1R/K0gAULXKlfavfyv6BmWSBy39p97oAfaOdjvfRfmofZ
         8ggUcuVYL37U4671rMnaZGSm7JG6tqGS3QLnMvALJQGbrJAHgdkzRSZ3slLgVyuM5zII
         MxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252147; x=1790856947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fy5LuBsGPiW7O1O+BIyf1gvIblzkLkWCpfb1huUexVk=;
        b=gSSP+UsHS1ljvuGZrOhmqWOtA823dfqgkCxyVGfefcwMbHPFTNM6tFKZdtX09zu1rR
         kZMxnPuO2XAARUOI8Ye4U/q0Ds2fuxV1nSRExKe67N9wYlCW7AICQj2l+Hj7IYOEvQkw
         FZFNRMlRESKfOEOckoJoLvscq1nsv2aFyB9ZPjEtzcNOZF9Ol+tHseMJkWALqfuhPOUi
         xJQdU+X0mlSOKM9EGlVsFBWYrJjH6t1E4YD+U9QuGySAnscins4huYsdhjOC28sjR/Gy
         NF82FiJNjC0uYegJHVfIiKciL4uuUkCaNN5hD2svuhp04cyU2EIdjn7QpUbEbTSZfp0b
         gnag==
X-Gm-Message-State: AFuF++nBMJaeC1PrFmH7K4E8pnSz2TuxFIbnNTmEXmEw72Kulcb3/kqV
	SnaOxjn8wtc+vM5eivpuRwNZuy0W32vtBI6dYOdy8GDBUsG/5euKfi6nOUWRQWe2giT82CPq6W/
	e5pZy4LDbySuXyoKNGRSZ41bWsNJYHyqzwRTssyUJGglJdU78hXfdqIIXrD8HPVdp5Xz/NpUBbs
	s=
X-Gm-Gg: AYBFou0q3MZgR3fs7H45/wOfIuLBWwZ2C96P4MMUC3UzhaN0pds/HsoP6NBgyjjTyEO
	MCERDtidQxWBTR+Xyv0GZmErUb4hrS04F/nEo6zYzsu1MmNsnoeqTems1yVOmbaQV01e3MsJtqu
	1wSJrVRKO/aIyxzYabacVS4Y2InKg6G/mTyxrYpBf3Lkeu9QBbR6byON1Dvub6yTui59EJGNlIX
	W5shy34HTY7mFA0oz4qYe9khSvPewTujaQ+fCKVCrclsbTE0VbxCg+ZwSoLu+pe2mfIommsbOyj
	fxVsj62haEp6in7QhPQRfbkgzyq02q5ftqSDkaI+TQYtKFtqTTVrTGojB9lmrkCoMUBLDr7Ho+Z
	5Y/dVkXhVNW2ngz5hYkm6biyR50K/aQ2ODGZSPKXTQWEC+eNTA0qBux+jqgvCgZ/6pXAv/pT3S0
	ftWxJcLJyBV3AiXUeJkh7h3FZ6wgKXmji92gtv4YFpwC2Vue/raUl7NzGkEbM5boSKekGSlFp+Q
	0O2JZ32F4Y=
X-Received: by 2002:a05:693c:66cf:10b0:33f:3878:8e18 with SMTP id 5a478bee46e88-33ffe33d418mr1823411eec.0.1790252146582;
        Thu, 24 Sep 2026 05:15:46 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625921asm13789258eec.15.2026.09.24.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:15:46 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Thu, 24 Sep 2026 20:15:34 +0800
Message-ID: <20260924121534.59349-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924115312.505d89fa@pumpkin>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <20260924115312.505d89fa@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 11:53:12 +0100 David Laight wrote:
>> @@ -117,6 +119,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>>  
>>  	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
>>  	SKB_GSO_CB(skb)->encap_level = 0;
>> +	SKB_GSO_CB(skb)->max_segs = min_t(unsigned int, max_segs, U16_MAX);
> 
> Why min_t ??

Fair point, min() is fine.
