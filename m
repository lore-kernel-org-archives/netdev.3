Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8C384CF0
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270368; cv=none; b=Wqs9lZ5jfLvCzxkEOQqZtJSWl54NiSU+raZJePoxJSL+pLKwcshDqXOAaY4KoAXFNMvdPaMbOiwQKsb4MaWIAJbfEJslkCQE47LQL0NBzSUMfAsTl8LYOkCotskhP1WthXflZF0zex847VRrTHOwlClCbgyVNjzNhEGl7e6mcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270368; c=relaxed/simple;
	bh=BD9OGmpZ3+fJbRvqNTy8brT1EJQoXKQTGDFIJKhBtpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FET5hhvQi/E07/pvZTSQFXhC+aRspAIs4gMRcFspZcsuJx2dwxoc4HzoRTHePVYKeH/an9ujQq3HYWttkKGq/L062m0w/fFGGiXNiLq7bDm1NUDGdvP2baRiIhJ9vHEYFtpah7XZedYLQcy/YI/jhUVctgNen7Iai0VDtBrgL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie/eSgiE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie/eSgiE"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so21163191fa.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789270365; x=1789875165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUxnSrKVNmwG9e50AFcOowKn93UYykTt4+mQ+2qxLTU=;
        b=ie/eSgiE8BtGZ37xl0C3cQMpi3wy/3wgt3prtU3UU1CmBHfF9oiXmm91fLJWFuvC3A
         dA7rwZrineOI/k4sqPZfhgQkB7fGO1/FDCrdnPJPNzF+vIYDn9ApMCk8oN9qG9ap72cT
         Jk/44EBmE5S5IxtSgd8sJdTu9OiAqJ5hH3rFc43SrRzIhNCY2N3T7gE1WGlPaaDAZgbl
         jPJPIX+wUSBAvduaBekXn/GEE1QZnIJGY+o4H4L6YLbl05nQZspzfOSA9BMltgmN/3Gs
         7GDepsWxqVZIRjrezMdYgNPmjwUa1BOwoEnA19eL/EvSV88olRYaGWhkjoaMG9uZN1yO
         YwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789270365; x=1789875165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUxnSrKVNmwG9e50AFcOowKn93UYykTt4+mQ+2qxLTU=;
        b=Wz9GeNsklY8jvfIJimNcyClCqR99w+ugaoTQixsTMmqNctQIhmqs3Y3rjYSdnTpbNi
         g6VOZqMnFEci6PoR4vSaTqLPPCZFQWY2cI4f1ChK9cyW1IrgRLf10oA6NG1Y+7qDwlyW
         snpSh05w9uHs8NyiYgU++x42YLZ4R85cGpSrVZqRoKFIifYZ2pR8PwY6f+sRE0PoqfHx
         eCtIQ1KEtv3GuWh6Vb2BCUWNG0qMThiQNxZj1SOXlNXorA2JS/RFu/X0dCHGeuhx3qb3
         kw6a1WlDxlaWLd4vx5QtvbcCDVwmZ/gH5Rfl4kcXqcszP7dwhUiyeQ4SRCPj7XvidFAf
         6UfA==
X-Gm-Message-State: AFuF++kjzF+cfZ6l4CsnlBCp+MDEOyB1j7S+4AbZnLDnjT8B4wo/Mr6/
	px8Kyldfcf8SPJU+0ADPK/HznVlfW/gJvodfWbqU+juFxNB1oIDCNCSn
X-Gm-Gg: AYBFou2oksEu45CnhH6dpKRW654M8XSEkHkmF9fMTN/Zl1iq557lCXSm9WyJHz4eQgW
	4KC62TSBqcPzjUu4NDMIukg3HgTYBaAWaJqeQZ6+btWd2NyveuIWfnj73e/3xQoWXeCSe9NScHo
	RZc9IF0RikNsoS75n0K1Yi8umhRXhOp/Kc139eGC4bjhKJc1UhyNU6AFpNHnXw7AaaTcJ3v7sKi
	0Q16Ok20oIEP4SnU/y6ca9MjUuHNs471GFciTsVYLgPnPdo0D8wJ5GD5lhSEYiC7bNKs7W6MiLP
	i/LujB1l32CtvOd2jh1Zy9bVSe8B5tILNtkT/QhuStBvV7Swkp1ljHTfs0Mb2+370VG3SWVDZ9+
	PnDQwe7twpMsYG56VGHtw+3HaHR3y8dEq1YVgE/xf1P6ZMghja7Z86qrUtg6rZuI5kMQ5lXi9na
	gANEroIzh97T2d/jjJJByypBjUI/VwgE34MoSuHTL6Xk67CLmPfHThy7YH6p8Rzr5SNvSd8Cf3D
	6eTIRfE0aPRaPCcAXps6d1H7JZcICOzlXykFnqpXHdZ
X-Received: by 2002:a2e:be90:0:b0:3a3:7682:499e with SMTP id 38308e7fff4ca-3a5a525304bmr12047681fa.19.1789270364978;
        Sat, 12 Sep 2026 20:32:44 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a33a1cd1sm17024041fa.42.2026.09.12.20.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:32:44 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] ip_tunnel: add drop reasons to the generic RX path
Date: Sun, 13 Sep 2026 06:31:53 +0300
Message-ID: <20260913033213.873609-3-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902184730.304d2d34@kernel.org>
References: <20260831215137.549324-1-littlesmilingcloud@gmail.com> <20260831215137.549324-2-littlesmilingcloud@gmail.com> <20260902184730.304d2d34@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 18:47:30 -0700 Jakub Kicinski wrote:
> >  	const struct iphdr *iph = ip_hdr(skb);
> > +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >  	int nh, err;  
> 
> reverse xmas tree

Fixed in v2, and not only here: the same was wrong in every block where
the series adds the declaration.  They grew when I gave them an
initialiser and I never went back over the ordering.
