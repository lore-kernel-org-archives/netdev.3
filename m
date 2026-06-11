Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFE3AA4EF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192617; cv=none; b=Fha+HV6OlMu4ZYjFo4nHfzlP+3kScTzfMCn/sxQgDtnAvdj/OENo2uIRZwKHCZNO+27iVFJ+Lv+8MB3q3TzbK/lsC5lh3aEHskaXZQqDOhk05JsCFaiybzsrMA9Y3LMfVWU4AQ4wQKHxafTHXwd2ur9w5D8VF/t2dOk+B1XTx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192617; c=relaxed/simple;
	bh=A0QPOoI1QIRAP6SkKhJ9Cz/S+rKbby6RT2vbilreIG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/Qt50s3xe2OctMp7mRD417V88m3gwWE5urM938ruDew8IxypPELOGY/Iru3cxyAJP94GaBfxE/FZ1JmItH0+PwRUNc+THO2g2MzFM7z8uTHjzU8tp288DOrKlWsU0AR0i94UjiVhJ4iHS4tgrOoQ4D5N5Y3xDHr5HRmRVXGbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0FLVvb99; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0FLVvb99"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4jiIEDw7ibC7pr1Oeixmred4ucoxw5g1PQU4U2G4UIA=; b=0FLVvb992wP0UbYkxzBAQg+rF+
	7DgZenEaKoCAZH++pqTkqRzVtiq54R3HiJjD2uRYOgHK8KRFE7CbpRCjxbb0r7uJZWGaeVjVKCTXr
	YR8Z5Kr+6Pzc0XkgyJ95lu42fXu6CZlyPiHvEM6CdK06DDqR+1EJ4l3Oun1izaxaQxoo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXhZ7-007BII-AL; Thu, 11 Jun 2026 17:43:33 +0200
Date: Thu, 11 Jun 2026 17:43:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Das, Shubham" <shubham.das@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>

> 2. Whether similar work has been proposed previously.

There was a presentation at netdev conf last year about this topic,
and how you use it to configure SERDES eyes. And then a long
discussion on the netdev mailing afterwards. You should read the
discussion, and incorporate the ideas. There was a couple of points
raised:

SERDES are also used for PCIe, USB, SATA, and they have similar
capabilities to a SERDES used for networking. Do we want a networking
specific solution, or something more generic?

You need to include lane information, since there can be 1, 2 or 4
lanes involved, and you need to specify which lane you want to test.

      Andrew
