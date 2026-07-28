Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2E3B14D9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244958; cv=none; b=ZKtUcd3usFjB1AoF8JrAu4dCJJ7Yz1bsxF8xdgHD+NsCnmCjn0vgxLF5A5gn52Haas0kdi6bbdUar/Vcj4d6rQ1Jr/5YBlAxbKRXhNJAKj/EC2iPGaY0wNV/6kXmEZVO13K+CVR0zG+u07LbUw/oBpl4/kaggC2Lt9la3Cx1OXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244958; c=relaxed/simple;
	bh=oobXFTHfdzXdPL+8ib1BEuopmYTDo8gYa71Yim7An58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXGIZ5BlI3H0rhmlScJzaUMLBusLZ2WDapsKmT3cov6lw8zKx9yf9jG6Osm6O1v4eqMk/kB2HVnqDEOIeg4tOS/uFv38o+E809M5BuorVBxExAzWzeukRn5PihO036JX8xHNHtURe6pUmW+0bpwB2v50tiu81lbNHfJsa3G5lKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVSD4ybk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVSD4ybk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3031130a91.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785244956; x=1785849756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oobXFTHfdzXdPL+8ib1BEuopmYTDo8gYa71Yim7An58=;
        b=AVSD4ybkB6cPOoh0us3loHO1zIhMPudA7qJjFAdmJE/zxenTvK9EL61gh4Idr1PMtY
         aEBlexwek5y1cDLgKWyfNCAFTkvkPB+raKe7xakfTRHVpzGhACpsd0DMj1hsWS0V4rhw
         WY2NFF0MiKmmBwcukrz/be4+Yb8/l3347K8IUiQy4OOz7hg5b3cSo/NF3omezGXoTD7Q
         ACIsNP6zFG0D+mgBl3d+kfCpmeiB9wfPkfvXniaqYOI3RmimRizntdHN3CzJOTb0rb+6
         lAraQFKUJc276p29k9Ma7v8gubD5OwUrhDtqfwfvHugyxn8xCRmiXmajLGetwOXr2n7+
         E/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244956; x=1785849756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oobXFTHfdzXdPL+8ib1BEuopmYTDo8gYa71Yim7An58=;
        b=Dvru9sqMVO76umDCxMRNjnDsEq0iFUU4Q3SH4PrlhaGoLe+eCdglBNejtqLxlMnJb3
         0QKybh9UxRc82HvWedBn2I/3ODQDTwbL6GhR3xLVQ/9+YGb2FS2ir08sg6px1AG+xG8v
         YzJ7aqOLIQaWsxVfzjqBzHJFbu5LV8d5j/8Wc4gtRWr+yfy1pxlkX358jEQ+VfjUhct7
         sDaqFt6VmYmv0YtnUZ2afFWWIeNpkij6KR9ImzF5H+H2x+j42YkivCAV1j1lyp7iehdg
         Eg2sX7Fpzq1rXtQlSlMAxe23eWNUZu/EmsiPr28RILLoMSC6iub4VtjRVV9ZvvfkQf26
         /BFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUpUt3CPBKllS0/IoRrDTIszrwl0hqZwV4HmMTJtrUA40MrMSDeJvCFhwp8LqfUilwNlWvdaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0Nx6hNss8pRA+ZY1bbftW4sNZPImf2X+naa2DyV5nW4YNnaE
	NHD8NLgvOIFTklpxMhefnHyFd1I7T+Q8VLmuw3bKSIXBITJPEuaOFIOW
X-Gm-Gg: AR+sD11VcuLA304eu/W5kZq51nDN9iTdzPrcdAcs7c4ECReCxvujoLa89M5sR822D//
	OF77yZ+ract6DG3nvrZk/YBQl0121Dc/CluojjInsm6dGuJAp5jEpkZPkSONg+SQ57cGGfckVJH
	CvDyuBhlkOjP0kGhsymXf/tCFsMnUxfNfTaaq9p3ZObJLiS09Y0epUUF/UJT++sX7KBBdHRrFq3
	6HOPLxS8kO2RJ6spar+E4c2GCXoTW9a7bl2F/7bjuXfdDcHWE04ZD4tcIhWDL7Z/NmMLAjZG60X
	O8acQHGVkOC6NPWc9EtZMCMDZhw7isgFO1CFesHPdO3NEw+sjmA33gkNA//6c6kd+/vSEyLRQdx
	XgfMfaJgz/7Wj0tAe1cV6jO/WUNeWmVraLeWLeWjpL8VkZhbjO4C5hFSp1JqP8cRSinKWtmC1CV
	Mq
X-Received: by 2002:a17:90b:3a4d:b0:38e:7239:b93b with SMTP id 98e67ed59e1d1-38f6a580748mr2307986a91.30.1785244956532;
        Tue, 28 Jul 2026 06:22:36 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6413fe85sm1376399a91.12.2026.07.28.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:22:35 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	rmk+kernel@armlinux.org.uk,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phylink: add phylink_pcs_loopback() method for PCS loopback support
Date: Tue, 28 Jul 2026 21:22:27 +0800
Message-Id: <20260728132227.4051026-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2c0c6864-99ea-48d6-a889-c886bb91c351@bootlin.com>
References: <2c0c6864-99ea-48d6-a889-c886bb91c351@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026 at 10:41:12AM +0200, Maxime Chevallier wrote:
> I'm actually seriously wondering if we shouldn't just stick to MAC
> loopback only for stmmac selftests. [...]
> Using an external loopback (in PCS, in PHY, somewhere else...) doesn't
> bring anything to the table given what we are testing today, which is
> internal stmmac behaviour. The MAC loopback happens at the GMII level,
> so everything we are currently testing happens before that.

You're right. MAC loopback at the GMII level already covers everything
stmmac selftests actually test (DMA, filtering, VLAN, checksum offload,
etc.). PCS acts only as external transceivers beyond the MAC boundary
and do not bring additional test coverage.

Given that, I will drop this PCS loopback patch series.

Thanks for the explanation!

Zxyan
