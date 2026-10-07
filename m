Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4D371053;
	Wed,  7 Oct 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417304; cv=pass; b=RKZhGahPkvIIH+802SEWlW+G8t9Gduiw3bDbUmMqgKXHkO4I5TE4aKk3F5WDrYgEyLF4Ednq1AjPob5PCu/fFyESIKbr3OXIt9Ov/6gn+sWCj5RJL7GABDxKx5guJrTD7Qd+26b5tR6IpSB3L/l7YJZQB9RsZwc/1/A//QmIcQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417304; c=relaxed/simple;
	bh=E6RcB5CiT08ttxDbgubS06G4yIp+Whv55XN3uzJFr+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uf6WoK2YEtOX2J5TExEcIvaY4hycPtUdf7dn7FHpl/rYoiqPaHTMX5p1AMRybTxwNQxSlEBMvPgkqixOrL6VBNyAxXiwrmui/jhajW5fjvFzHJIg0EAbmOg3wnPpUmhcpC2kXNqZEtJeYbmOunc5WnlDX84V5q/X+AXskGUqohY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=RePklWXq; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="RePklWXq"
ARC-Seal: i=1; a=rsa-sha256; t=1791417284; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jsY5r7vFEL21347tqU3QcjIn3q7SW8VSH2oNbdXUGinMGFQgCEHL5JnhhAyucFhFRRRc+4IRY9PGi3NXbzfxyi3lZywPgdi5vsH8KJYEkMUWJfWvyY7L90EVDcQpiIgo+NPYqDKeAE4rmAdhODPM+YHegupg30It8UDk4b+Gk6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791417284; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E6RcB5CiT08ttxDbgubS06G4yIp+Whv55XN3uzJFr+g=; 
	b=KDpsh4NUmvM00fl5wbLIPATyPjsVYBakBezFgmH47GZx48iOc3huacYn7oj4F0pqX34LzzvX7JEtAPNZGrm3T6QIp+C3KhIYq/FrSaMX/1xRBxnxRjrfm+40fZLB9sKI/txC7TGNgnS3kC6dBBbMfAOOp4RMK6FJYvEjx29zFEw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791417283;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=E6RcB5CiT08ttxDbgubS06G4yIp+Whv55XN3uzJFr+g=;
	b=RePklWXq5Msqwzez6R4WgZ2y9UFEnyWApFcg1+ilSgdYSjfNVictAeJFb6LtcKDL
	BjUKQZnWGtuk+ATpGv8dBxONMZLiv+iLeyX0vwseLSCErPplmgVVSNecOv5S21leQdd
	vtdRpNU2EAUYYvru5iXy/9peSQRP7F3wujRjiQ58=
Received: by smtp.zoho.eu with SMTPS id 179141728018592.3187470738884;
	Thu, 8 Oct 2026 01:54:40 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michael Stapelberg <michael@stapelberg.de>, linux-kernel@vger.kernel.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH net v4] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
In-Reply-To: <20261007182112.821061-1-rosenp@gmail.com>
References: <20261007182112.821061-1-rosenp@gmail.com>
Date: Thu, 08 Oct 2026 02:54:25 +0300
Message-ID: <179141726511.545895.12266951911761895501@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Tested-by: Igor Velkov <iav@iav.lv>

Helios4 (Armada 388, 88E1512), 7.2.9. With this patch WOL_EIE stays set
over 3 link down/up cycles, "wol d" clears it, and a magic packet on a
running board is a handled interrupt. Without it, WOL_EIE is lost on the
first down/up, survives "wol d", and the magic packet is an unhandled
interrupt.

--
Igor Velkov
