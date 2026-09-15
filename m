Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43C943A812
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463511; cv=none; b=I2O9a8TOTNc7JvmEiPZFrBPd4Q6lZC7rWotRJVVhIdTpcOiJ3QHpdHXkNefUSiAbLuKPCCWO/WWWeBBM6n3NQCBstD7KlcTgtr8crT+1OsWeEEmaEerJ2WHe8vRCh49DURUJEduvmAzHL35L334jFqHxQpxB0rshGq329yBL/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463511; c=relaxed/simple;
	bh=DZY/0oI6mCnWUve6D7j+vwx+OdhyO4q+XgrHXvoBa3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh0ZQs0/D4ll5Ct65LbKSz6czRhf2SFbtJHku1rNVQpdp9gRLdQYWtFMFbTSqX2qxh9risHgvQ4/At0uB39zkMPx2Q7xSrY4K3jTV90NW1IHlMafbCi+3qq8xGs9BZ8f6bT376QXM3fOcNNxnfXXXwXyJH3FW6OIRrrdLNT6804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUDszfQv; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUDszfQv"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f56039dso8362566b.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463508; x=1790068308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xTNpzrYwTyZX7H+h2rvNKx7E/X9ORfxmeaOuxO0zcfQ=;
        b=MUDszfQv96UPwPS5ok4vuNwBOTLjcfqtyCffTdzm0seTn5xh8LMoHdS0cKrSP8/Dvn
         HQMrmZbD5/xplZyvkYov+XrkwI2RjeeUJ3j8d8kf3ZZo6XH8OsFT1JmzCExHWzP0yMd2
         00VcuHrOyUS9qst6pmgF9GdhJ6Vpqgmz8ywmA6gOKrvboEVIIC3eh6w99sZ/P+n+qAyD
         fI814Js+YigS4H3pJrgWPhOzA+XFQtTDhd6Qr9StURQEOy3JJ0kXx7FWyVnD+spjn7VK
         MmWvOHHCRdlNb60ZfO/6b/c8YvR05YFSg4869KCQM6KFb6rpkLvM+a4hcenNwOS8F7uN
         F+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463508; x=1790068308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTNpzrYwTyZX7H+h2rvNKx7E/X9ORfxmeaOuxO0zcfQ=;
        b=bbIVjTDa26ec7HYu9sFJRtVpu0PSOOTMHiDwDHfalj5m+PehWdUKkd3KYJ2drGaFD4
         xDjnJsasSJ2QScdqjh/6hrhErY2JJbIIcIFucBBSpZtt8V6z5r/XJ4nhd0Ejy5Tt+rZG
         5Lskdj9A3jQA/0Fpen1AoCPw9bb4+ue4m0cr6v811W7Az1gJZvaIOD/Cd6v5S+7rfri4
         6wZ7o0eCQMMXDJ/Qz4eOPSTyraJTuw2VRTl9BTiDtclxI/rlCMFOLki2GGUSCDXMPXLA
         yUS+rs4wOqBn4eUUv508e/+RC/vORQkMRDUsTvXaywticiyF4LAbBVV4Px+ka6FPialZ
         lSLQ==
X-Forwarded-Encrypted: i=1; AKwUvByqgDZvnsn+tjWrsLOa2ETIhNSSDE5K1/Mdwnn5B0gq49BQnLmNSxd7iugao6Kk1ja6Ea/RntE=@vger.kernel.org
X-Gm-Message-State: AFuF++kS4hlEXjiErOUpFhx8T/dh48DNalAfsxl0LiGnHG7GiqoXlcyF
	mR0iRJvzJOXOaNkt7E94ufIwXRtfwUg7UDHUvcdtzkpvg42X7IPtu5ne
X-Gm-Gg: AYBFou3KVI9V918gqhpqbkiXR9Oazh16gk1ZpR3DKlq/LuTa14/vIvrj+rjTxfap4Eq
	BuD4NVOSzhGO0u47D8hUhZox+fC22WldJbrQsC+QcRo74l3TxfYoYXCcuZ+UXYWQOEO/hjt2q/F
	/yTFyghqZmUu0gepsHZ0xVnEO1rxDYpAobZO/RxDInEezTOQf0t8Wf+jZYdq8BbqOuQ41c0lEKV
	zEGli0DIXm9xhxUS38KbhzycBCWTAXp5wiFtCA582njsDFCypouO0ED+ERlGSzy1VQWv4aIXnPW
	HUYEU5lm+MdLj8mG7Bwluu7tZwaeGAN8CWQkD3RpAfsAm/CHPjC+D1K3BEFc+Kyvjt18ql7KN9p
	Wuf7semeeih6vdbFUdWliEVT6OCZIdI0+LqINu6HAmsbInf/98ykD46Hi27yZNNEGW/Z0wRadxA
	d1ZfuHpbohyinNI56Wt11zJ6ox8UMcNjygNqimLybbFWyYWaeYdKnKaW10ab7eikqoaQpXBLDbV
	IC7Gfjmfw==
X-Received: by 2002:a17:907:8995:b0:c29:53ed:f0c6 with SMTP id a640c23a62f3a-c29d779c3aamr23025166b.17.1789463507903;
        Tue, 15 Sep 2026 02:11:47 -0700 (PDT)
Received: from mobilestation ([185.195.191.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e8a1sm552850266b.6.2026.09.15.02.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:11:47 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:11:43 +0300
From: Joseph Steel <recv.jo@gmail.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, shuah@kernel.org, 
	joabreu@synopsys.com, yi.fang.gan@intel.com, jun.ann.lai@intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 3/7] net: stmmac: Rework S-VLAN handling
Message-ID: <ybotecadvx2x3ucgqjunv77fuyeaxmwl5tn77fswraztiklrdo@ajhpl4c52hcy>
References: <20260908164309.59282-1-ovidiu.panait.rb@renesas.com>
 <20260908164309.59282-4-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908164309.59282-4-ovidiu.panait.rb@renesas.com>

Hi

On Tue, Sep 08, 2026 at 04:43:05PM +0000, Ovidiu Panait wrote:
> The ESVL and DOVLTC bits control S-VLAN tag processing and have
> nothing to do with the double VLAN feature, which only provides a way
> to process an additional inner VLAN tag. However, the driver code
> that handles them always refers to "double VLAN", which is unrelated
> and makes the implementation confusing. The driver does not use any
> of the inner VLAN tag features, and the networking core does not
> support offloads for the inner tag anyway.
> 
> To simplify the logic and to reduce the confusion regarding S-Tag vs
> double VLAN handling, drop the is_double logic and add a hw_svlan_en
> flag that is set when S-Tag hardware handling is enabled.

I believe I suggested to just change the "double" word to "svlan", and
not to drop the respective logic completely. The number of S-VLAN tags
added/removed must be still counted, otherwise any subsequent VLAN
S-Tag removal will disable S-VLAN processing even if there are S-Tags
left added.

-Joseph

> 

