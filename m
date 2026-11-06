Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927249;
	b=ErcODQmE70kG4y1iw+we3Y2X54fGFS28eOAL3YNNupnWFSybM27VcSeoYDp8925R6qn3
	 ivwGso+7HAMkjhM6v1LdGN4vB8HxYEuvbtsIaOnOooMAtl6Jt1iSXV6e0BMFXoBDCRSAE
	 v9c4i8v55KvGEsTNhEI20Ojg4srw438XslzKcH3wbJUk4ZSGbkWQ+iOaRji5O1U9l5UHE
	 +cfmWosFB65EZbMvF46JKs5Op8NAgepnS6/Ruy74YpKlFYILdBdpDn5RebmR6t6PITw6Z
	 xU8zMrsovUJRE1i7UEz3o6kxd3tqE7ukjVodUy6a3g3JLeJpMURowaRbgpLUcBMaCmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927249;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=elrayfJ8Lsod/x4Ua2Yu7iaEDco08MZQLgnMqr8Pn7g=;
	b=nv3MKY36US5A8A+XcSs83Bq0kLzFObTy0RFnwwZP+g4IDCgVcUM9/Yp/BCnapn/sZp8Y
	 CXJeGyMINcvS4ae599ZtzEUos+qaZR1RRdZLJ5tdcfP0K11KqUQ7Bs6QkDF/1EHvc9zW5
	 imAqqkTXFhJKtaVIezQ445EDglntDmiZwWd4aGBfZkLhKiiB2km//ChKvnLpafTZyPXym
	 Gq0vlE1jkyY/8hf0sddU2XjU8dpd38klMD7CZq5kgbXqkQ5LXfTXkvYiY1DR47b0ldOFl
	 iTR0K0nsDMUFxIy4gAzNwP2h+U/CE/6egn9EJF5oKcOrYmASQ4mXZdd96vZV+B8GOCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=GDKnYP6z;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10801606A31B;
	Fri,  6 Nov 2026 01:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10801606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=GDKnYP6z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=GDKnYP6zw/yJZwXBJJSGewcKSCerNA74OXfl5RHvyAr5ydEgdqHpSJ0yw3BtEIFrcxO8197aIutp+
	 gKigDO68hVigZUvnfBhJOSiTqYtcKCe8c7qPLXgpyn6b65vbeQMfabo2bZ/eEwq7hYhtaFNFhPAlLh
	 kWfAEt4OVHegNLUY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76aed284d869-aad7e;
	Fri, 06 Nov 2026 09:07:25 +0800 (CST)
X-RM-TRANSID:2ee76aed284d869-aad7e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96aed284b367-0b481;
	Fri, 06 Nov 2026 09:07:25 +0800 (CST)
X-RM-TRANSID:2ee96aed284b367-0b481
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, nuno.sa@analog.com, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped
In-Reply-To: <b8f6cb77-2e36-48d6-b8c5-95e734054930@lunn.ch>
References: <20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com> <b8f6cb77-2e36-48d6-b8c5-95e734054930@lunn.ch>
Date: Fri, 06 Nov 2026 09:07:23 +0800
Message-ID: <20261106-adin1110-net-stop-cc-1-yuehongwu@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

> Since this is an analogue devices device, don't you think Cc:ing
> "Nuno Sá" <nuno.sa@analog.com> would be good?

You are right, sorry about that.  I ran get_maintainer.pl in a tree
without git history, so the commit-signers did not show up in my Cc list
at all and I only picked the maintainers and the open lists.

Adding Nuno, Heiner and Chen here.  There is no code change, so the v2
currently in patchwork is still the version to review:

https://patchwork.kernel.org/project/netdevbpf/patch/20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com/

I can resend it as a v3 with the Cc list fixed if you would rather have
the patch in everyone's inbox -- just say the word.



