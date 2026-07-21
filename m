Received: from sender-op-o18.zoho.eu (sender-op-o18.zoho.eu [136.143.169.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC2331A77;
	Tue, 21 Jul 2026 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634875; cv=pass; b=Z4z+StrYu7bvH8iU1oSG4pJxfmRLOMCbkE95FwZMUcxDbR1i5en58zlMEsZE0Gj/fJaJFuV5hzFQEl87XNDtMv8MSgVgL+P/cocT6bCbV6UVr85N0IPglzqm6RKvfQrdzUlM2mzde2AucBZH6RPslYiuiG7y2asfn/rHoRloazY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634875; c=relaxed/simple;
	bh=10BDBn6TgDLvhboV0X44b56erioXrvP72FEVRHOtTeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZFIUMuykJWFaf/ngCa1wKpIb3OAY0B1BdxzXy1ELkoRSUPWo6ivbcuZbTByPtR+OPIdBYowP/f9v8UGTHivKd5Za0MphXBq2VdryKH+E+/u/U7yHgK11n4vSWS2I5w7j9mCj1AkneHyxC5B5IrbET3BoHdfGEmwfGZTCwv9KiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=JA9n8H6u; arc=pass smtp.client-ip=136.143.169.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="JA9n8H6u"
ARC-Seal: i=1; a=rsa-sha256; t=1784634853; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=FcvHzCmh0fUnZPngdYnbzlYMe3YOBwwAmWB0hoQJ/80+g4UdFb2AkeHVbyvME9NQwvLEm8/EYcqXg7agUJyZRY1PoP+N41tga5WhhxCf665Zk6aKd0BpUQmAqD0AfMt1Xy/cyiOP1IEylKK137/VVqtoMfyJXmYMhsvdPjWX+2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784634853; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=10BDBn6TgDLvhboV0X44b56erioXrvP72FEVRHOtTeI=; 
	b=dEFomy/vHvkoWF7bdFZKbxRURzmFULG+I8JjqQyC/HRNpDW6IEFzocDvNa3xPriVdqGvd1VqdIbTdP3HMD81z6CuQw1jXUYipcaVys0zgH2EM7AvpiiiFjutI50wNfOFET5cBfnhIWwlwXUGOlEoZoORcnkso2+Bmz3XMWqvuj4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784634853;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=10BDBn6TgDLvhboV0X44b56erioXrvP72FEVRHOtTeI=;
	b=JA9n8H6ucX4ZDthMKvU+Vhchjk1lDElm8FGXzEHhQCy4LEuNI5DOaacDQ990htdx
	iL/Vs6rKl4quHmWLu+FNWRRO7PO19m2Xj2+IN6qn1yJHJDpT3GYPJSa3OUJ9aw4EWrI
	c5xELerqr0KYkocsbNZXBWHSFiO97txjDfEsQoTU=
Received: by mx.zoho.eu with SMTPS id 178463485160650.58420496911583;
	Tue, 21 Jul 2026 13:54:11 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovpn: prevent UAF re-add to by_transp_addr on float-vs-delete race
Date: Tue, 21 Jul 2026 13:54:08 +0200
Message-ID: <20260721115408.17307-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <524c6b9d-352c-4f84-bc8a-802dad97d909@openvpn.net>
References: <524c6b9d-352c-4f84-bc8a-802dad97d909@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Thanks for the pointer, and no worries about the delay. That commit is
the same fix -- please drop mine, I'll drop it on my side. Thanks for
handling it.

Ibrahim
