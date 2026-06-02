Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134B03126DA;
	Tue,  2 Jun 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405381; cv=none; b=J2luix6KXbjePqSiUKSSoi1FOnCy3lY6a+Hbi0DfgUvGznD2gwtvkuBQ5iru0QwvO80Nh4Qpw/CU35C7uk3G2nroncqb+SG9m5ugkH86KTgTFw/3di4dQ+mfG2heuIj5Eh0WXPxVQNCLxvPK/N/4Olk2Ei/36CUotPgoFVHiFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405381; c=relaxed/simple;
	bh=K8gZMyX58NO1IoitPIodZiSwnQ9rSGwqgieXlOVcDkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my0/Q94/XEi8Ux707eTKefFquenxh5Y9c2wM/k5eiGPtHMqeLvnueXQDVzvyoLDRWmbch4R/BPQ/bXcOJ/9XmxMaWQtAcKCW2+YztFpzVT5njznHlbX43kDDLzAabONaBvcUm6sy+cb0p02ga0LpBJSDZk98SBb8cV/63fg3Oe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ViX3CdC1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ViX3CdC1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6QzuOiqqaU8ImmmaoAkaSFhjXBK7kZ0ksHzE+A3Y+4o=; b=ViX3CdC1to93eadUVyOZn8aZcQ
	sVR6LsTI3HtkovxFIo8W+gHQRNQzw13EsiijepRw0wr+1dnbtTLorPV8ys70sD2cvnO11G6/zpmH0
	NXAXQWl3Twx+9Sov1jJvuKJ8vut4Fp7fu6Sm56FBafKHmDf+hawo48xBk5JPTdd5rmwU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOle-005gt4-0E; Tue, 02 Jun 2026 15:02:50 +0200
Date: Tue, 2 Jun 2026 15:02:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <7fe02d9d-3409-43c3-884b-4a0107400a7a@lunn.ch>
References: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <8331c347-4d40-43ac-aa73-a22398ac76a6@lunn.ch>
 <CY8PR02MB92498165068F7C2FAF9635C883122@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92498165068F7C2FAF9635C883122@CY8PR02MB9249.namprd02.prod.outlook.com>

On Tue, Jun 02, 2026 at 02:30:02AM +0000, Selvamani Rajagopal wrote:
> > 
> > > +#define S2500_MMS_MII (S2500_OA_TC6_MACPHY_MMS0 << 16)
> > > +#define S2500_MMS_MAC (S2500_OA_TC6_MAC_MMS1 << 16)
> > > +#define S2500_MMS_PCS (OA_TC6_PHY_C45_PCS_MMS2 << 16)
> > > +#define S2500_MMS_PMDPMA (OA_TC6_PHY_C45_PMA_PMD_MMS3 << 16)
> > > +#define S2500_MMS_VS1 (S2500_OA_TC6_VS1_MMS12 << 16)
> > > +#define S2500_MMS_VS2 (OA_TC6_PHY_C45_VS_PLCA_MMS4 << 16)
> > 
> > This kind of suggests we should rethink the API for reading/writing
> > registers. It should be possible to pass MMS and register as seperate
> > values, and let the core combine them.
> 
> 
> I agree. In fact, onsemi's original implementation had MMS and address as separate parameter. 
> It is going to touch all the files. Let me know whether you want to do, If so, when.

I already suggested adding _mms() versions for register read/write. We
can leave any using MMS 0 alone, and only use these wrappers for !
0. That should make the patch smaller.

> > > + /* Convert the OID in host byte order */
> > > + for (i = 2; i >= 0; --i) {
> > > + addr[i] = 0;
> > > + for (j = 0; j < 8; ++j) {
> > > + addr[i] |= (val & 1) << (7 - j);
> > > + val >>= 1;
> > > + }
> > > + }
> > 
> > That seems pretty complex. What exactly is it doing?
> 
> Could have been well commented. According to datesheet, phy-id-reg[16:31] mapped to OUI[2:17] and 
> phy-id-reg[8:15] mapped to OUI[18:23]. I will add this to the comment.

What you might want to use FIELD_PREP, etc. See if that makes the code
more readable.

	Andrew
