Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88143A819
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011814; cv=none; b=KeNs2rFOFlVzQNwoD7vIVC/lBC+AL7Dp4oi+g/GxdY2fOKhDuZHZKD4NqlahaY5h8JsAjVfk7JFPlGFwYLzNeAy1llDjdP58IR2NS2znmiGG0hzCc7MoqeqilRqsuows0S6AYZQrKA7TIGCYcQKrXBe/wsl6ZWq995Wo54QYA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011814; c=relaxed/simple;
	bh=DPPGMlhCK/Jt0HlEn24QqXQAUu9fpcor/f2kkCNnxOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWeWXZeaO792Uk3IWikDf23MHinZT33eeLQKz3qeu5ZvrjNRQFAKret6vtvz9+ZdPX8ktuZUbWv0dIEyUdQ0/S9VBmUMCoM6oIqHYNb9Di99HzI99rhcnih0PaW07ceqNCL6OJ+mVjkP4zchwuZPY+KHTILNJqFUNpdstzTCElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3YZNMQa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3YZNMQa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4957799b92fso1656875e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011811; x=1786616611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E08fZo9KB48N6tVhom0sp2LFhhwJahQDfyCHAaGb0WQ=;
        b=A3YZNMQaqz+4ocB+uim8xCwr+IT7F0F5SF26EZtwevj3DREXF1fwd543eWbwv7da+U
         dZfja/5T6+ofVQS1A11sDjICCnfuOo/8co7kv5199YOCKmeXn23g/I52ktdhcu/ZEJIK
         ZyCYIMOGSjFSdvFmgpNdaUbad3fIe8mYpkvX+mypypNKjOsninqfKevidy0GExarWwuv
         O64XBIO3twA4Qj3mDW4B5Xf54PpiVVdQAN/VidiQgj0X824KbQdiEVDAkOy685sW7KYr
         9lKvZmc1DJHlby/4HM8shGki1m/pQC2Yu/JeQOwO+xMfegdG6GF3ecDcDdSsbTPnMXOp
         92Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011811; x=1786616611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E08fZo9KB48N6tVhom0sp2LFhhwJahQDfyCHAaGb0WQ=;
        b=Gz4H5lL79QiG7M966fDAYQB1ipfsAYdgvlB1IH/VdPZoLoLC7wVtNSM6dJfmgJQ45j
         hiCOyGsE7bofDFf1c70rqef3y+13rIDUCB2E/XaP4XpPZOV53UJr4+x6NPl1tLxH6V4s
         3nSpGCLnz00o0X++XCnhXbJaRM4cD0xYsVC3gbnj2qAHLFmZICM3BlYI6240X3HrWWow
         DVKo557g6rd36jPJyqVqcJYj8ppWd9EykZcPs6TG/yZhj07xgpXXjAwHGkZAllgr2T4e
         OsC7jmInR1va1P3sXYzLLBxTDWollohttYE+acJcuEsaxJ4+0yf/x94e3hoOU6281X0+
         KQQw==
X-Forwarded-Encrypted: i=1; AHgh+RoK8K9ZPMVQoH/KkieuQ/S9D66QsSCFDd83ieAqQydTcgnAQN5Br4vGMWXPI+6ADRhPzx5leYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6sUV140MY0pHP26Z2TPHl6xLxUMcMDodhVLmEZphuN5l6YoG
	V+ekvyBhFm8kg9NsXl5N7te+qCWi4bZEXcQqaJHYwXBxlWipdZvZqh/4
X-Gm-Gg: AR+sD117WphOYeknW6MPaj0U4qh4TCxA0VGo8gXCubLBCPitJI8u5jYg+y2nJMoQ6Z+
	2EQmq12F18gnSjEmM0GCIB+Ml8hBye8ykJTlbKrOlo47XJ4ChP/R07OrZDyrZ/N/dVegkiuHQwb
	PGRv1xCr7H1cVNsGcfcsaEMYJntBI1QOUGU4QxpCyujvdxO0FKAGEVbwG7+SGerKtQaGw1RtZJ5
	H8xT8bAufAckHPj3V0jnIUjFf+2xcWkW3wpcizDdAVTjvsoqDBVZa6J7TKE7PjrluHjLyq6wiUH
	7okds2rFNG71n69J9u9h1pzvL5trNyorw+B4Xc6WGb+f2mk5rpCpMkYEzZu4fl5Jqha93pxCXX8
	NwKr7RPSAnsweTodjJKCRkW9RsNFEbY8ok2AECPLoac2GqrMOtDSEYi79qTmAnzLvVPvP9M+4R/
	toidCGYcI93NyegzVdL6KHN5e2KOnivXNSy8GxQGQqAgcXG8Z/bGvj
X-Received: by 2002:a05:600c:1c22:b0:495:71ff:598d with SMTP id 5b1f17b1804b1-4994edf895dmr82139575e9.1.1786011811067;
        Thu, 06 Aug 2026 03:23:31 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d801:b100:3c1b:726e:a458:5bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542241c4sm49032335e9.11.2026.08.06.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:23:30 -0700 (PDT)
Date: Thu, 6 Aug 2026 13:23:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
Message-ID: <20260806102327.wrig23oltjzogyi7@skbuf>
References: <20260805072641.402-1-strst.gs@gmail.com>
 <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>

On Wed, Aug 05, 2026 at 09:44:51AM +0200, Jonas Gorski wrote:
> While SVL is active, any ARL add/remove operations ignore the VID
> field/register and force it to 0, making existing static ARL entries
> with VID != 0 inaccessible, and any (static) ARL entries added will
> have their VID set to 0, regardless what the software entry said.

Is this a hardware limitation, or is it because global state
(dev->vlan_enabled) blinds b53_arl_rw_op()'s attempts to look at FDB
entries of the other type?

static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
{
	u8 reg;

	if (op > ARLTBL_RW)
		return -EINVAL;

	b53_read8(dev, B53_ARLIO_PAGE, B53_ARLTBL_RW_CTRL, &reg);
	reg |= ARLTBL_START_DONE;
	if (op)
		reg |= ARLTBL_RW;
	else
		reg &= ~ARLTBL_RW;
	if (dev->vlan_enabled)
		reg &= ~ARLTBL_IVL_SVL_SELECT;
	else
		reg |= ARLTBL_IVL_SVL_SELECT;
	b53_write8(dev, B53_ARLIO_PAGE, B53_ARLTBL_RW_CTRL, reg);

	return b53_arl_op_wait(dev);
}
