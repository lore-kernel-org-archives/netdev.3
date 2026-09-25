Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A363AE6FB
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322374; cv=none; b=pGwSCuMghuqM14RK+w4kAIn/+eUBCIMicvFweKNzIEZKzLuw8Rx7PrF1Ly+sqKHz5FMMhX2+tMHtEL16kS2U5w1kQNryZqdnb0RjpkYSsb/6Z6gmWxOsM7qVmjeuxqpPV5UtVmmIJ58PhKNyzrsljZwG0mV35vp3VG54L84uhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322374; c=relaxed/simple;
	bh=yw1JqgVMYUSNxBiAgnL2DguWZpDJxy8Iqoi6nytM+Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOYQYEkLLzgDBhoC/1H5wXYCGBvFmtNkUL2+WhcI6o7Z4XWA3T0N/Kmd/JjGle3bq7PyFOJ+2FLu/ooMuvj1LxHXkXNHELufHlcKwIpDFH7Ngq/PZG1IbkY9Y6ocy/6B1lPvCFVk/gHsGEMCzdbaWidhpZtIzPpXftlLPEacpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=FhK+8a9K; arc=none smtp.client-ip=74.125.229.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="FhK+8a9K"
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-33c1024dbf9so207346eec.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790322370; x=1790927170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e+mPFK3a0EV4gRWxwlNF0dBaFvCh9e2wcOZSVnfSL3Q=;
        b=FhK+8a9KIsaffqLjIHRJzoESfrs3/kHZTVdMKh2Oikqbu70L2q45LMihQmmXSwLRP/
         tiU9dBBwJ5Vd+RZYa3BJuFV6crs5XGW1efZ5KB3ex55jjjtpu4BrtJqgAnuS2Sr/pXhT
         BdrbzFZUZ/PoLnNMiAKhsZvmaBw7WEHviAQaXM0H04x5jfHSXXDp6XdHseVQebU8n+Ue
         rXQQJahJqfDEgOyoQSiQfUYlgAzET4UE46dwqhMJYRgl3Hvl1EVhhbpRLlN5eL/41X7n
         vng1u+6WRJ2V1dnaVRPG97zkpQAcoBg2zWJ3cE59SnjBsvbA8Pm0Q2rEfc7fPm6QTeuO
         oKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790322370; x=1790927170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e+mPFK3a0EV4gRWxwlNF0dBaFvCh9e2wcOZSVnfSL3Q=;
        b=kTZtnBc6UI59kPQcUXRfdzz9bnnFZjbgfOTLokxDfZdYGdWT5GJGg2DIt5X8dMznA5
         JZl2Atqj9F8UKQU+ywUYM3JBsAgOH69+56Cf3TU1+0tNY11Xl8pLKWaYh+X+NBOFLOUR
         0awlxfJa0g3TX7J+QTXCFN14g33c8oPPXExn4twDOQJ8bjT3W/v+7gYjrS7hhCxtmXsc
         VxAQ0vlVkzgRvcYVxGMjnf2x6KnJsP8zazEzw0OOGD0Qn+pJLV2bl4LzqtjAdprUGMvU
         O5Jqqy+Nq7GTB699W0PLRDK/UPoPGEDmTWdclAf09tldwn3gwwkHk+/N2DgsIUyakgbY
         qZuQ==
X-Gm-Message-State: AFuF++kGeFxOkn/WY+UnF7+FrYgDlW75zGU9MEzTs45oOocZ8HU3jAOu
	Cr4zTzDOKIh6yK9yTMoVbF1LMI7Hvl9zLxBagKBMuDxSXskJKyYwSq+AcRobSwVL7jFy6rWo62D
	jn0o/ZTIGXytLo1zrPoDHSuvvj7ZE3IyMXqDm4Bioqh4Dd6pmlKmQ+HN7pzqsq3a2aFpHqWM8//
	D4LA==
X-Gm-Gg: AYBFou231khib63xeYyjRVEfPdYxMfFeM5QxgchmnK11RszcB3twLghWdtX7mbCx+ZX
	/mbGVbYHwdO/rc24qOmL6cA6FkgEscU6cl8beHh+LZJwdc1Ov5D7PTeL7SaGuF+YGya+YlQG9/7
	/mWKjMT1Sa2LXbreEbb6JZPI08/xyTT3j3iETWWhOLDBF/EwP+/lvp9TiJNz01DA4VM7bMwJ/fE
	s6Ewy9WYL6yTYWRCjm+QjahYGi10dCIQTCT7SSb9aVMjbBKZpFWGIUNEFav/+xIsR7o3JblBYYa
	OymoYU3IZdYhTKspZNoXQgCXr7M/QfiogkdrmCThNgyDoxlsQgWFwRjaR7dsf8gVZd84f3lgSBu
	AU1lqhKlrEEklNVRAn9W4fXi3ZUk95KykkM8hhDa7j/9mc5/3lAVVdwSAZdpejrtViuXPcseakG
	5qgXSzLiIHqhO6qooh0b+srJjpP1b2A0eZmDP3HE+kVxJjI3Kq2tWeUQ3pRjATJUcZIbOUEC8VO
	fNyT4Zp43A=
X-Received: by 2002:a05:7301:b0a:b0:33e:bd05:81ff with SMTP id 5a478bee46e88-34003ca6d83mr3225802eec.8.1790322369268;
        Fri, 25 Sep 2026 00:46:09 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341451457d0sm5017845eec.21.2026.09.25.00.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 00:46:08 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
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
Date: Fri, 25 Sep 2026 15:45:25 +0800
Message-ID: <20260925074525.91040-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <611ec0af-8e4c-495d-9300-6dc9b5d616a1@redhat.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <611ec0af-8e4c-495d-9300-6dc9b5d616a1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 16:09:39 +0200 Paolo Abeni wrote:
> I'm wondering if this patch is needed at all. Can't the special gso caller
> set skb_shinfo(skb)->gso_size to ~64K and adjust the gso bits in the shared
> info afterwards?

That would work, and it keeps the logic in one place without a new cb field,
but I don't think it's better than the current approach.

It would need skb_unclone() before writing skb_shinfo(), and a repeat of the
if (partial_segs) logic from skb_segment().  For DF=0 we would also have to
recompute ip.id in validate_xmit_skb(), or keep that case on the existing
full-segmentation path.
