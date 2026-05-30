Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944C24DCF9;
	Sat, 30 May 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780152548; cv=none; b=Uf4NedfxNQ/O41oFAiTqxFRpxo3tfqPQrzx6nSCq8aTBmVR8qsLDmnu5s9XYHzu4rcHADGawAL4keyp4F+ud7pdHhG/6HlwjhuKibfWK6nqnjdRpW8TbYqqpR5XT1by474olfiPHqFejvepRUmKxsSQIawkPQmggjQ+pJ4Ueigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780152548; c=relaxed/simple;
	bh=ASig4cmZLZEuprGqWMRVAL9X+aZ5/BZk8T7Q/hCqzwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0xvv/AxBhqqrXx/X13kV50NOBmASwI1SmRc5eymb6yle1a2OCpCncQKsL2YUPUPHjxao2vbvYJXaMMayMoJrCwh0x/W8IImMR3xWt6cZHtBQ5rla292cOQwxz8kNGS6unZqqlGxkEtTcYROeLn1PXKDDVUgIFH+tj8RAsQakqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1j1e/5JC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1j1e/5JC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s2HEI+58LKyND1xKPNxSFoRUdhuqR9WKZIFIoOUpvTo=; b=1j1e/5JCIGLHI5Tfo2ZzRqIK5Q
	wUdms5VqGsx6ORpPxFTEOpYxFPhephXobr9zjivxm91DsAy5fv5y3JbexzS70tR0biX/IZqT72W1H
	P2TcVJyuMHymdNoytwgjcAhH19AHvrQMf9lZ8l1lsp2t2Z51IIPvl7QuJvkuOIwjDd+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTKzd-005GQC-2z; Sat, 30 May 2026 16:48:53 +0200
Date: Sat, 30 May 2026 16:48:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 13/14] dt-bindings: net: add onsemi's S2500
Message-ID: <4f109e08-9260-452b-8f09-97894faa6e8b@lunn.ch>
References: <CY8PR02MB92494D02A1209BC9BC72EAC883162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260530-adventurous-venerable-buffalo-edd6d4@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530-adventurous-venerable-buffalo-edd6d4@quoll>

On Sat, May 30, 2026 at 11:00:02AM +0200, Krzysztof Kozlowski wrote:
> On Fri, May 29, 2026 at 06:41:35PM +0000, Selvamani Rajagopal wrote:
> > Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg
> > compliant Ethernet transceiver device.
> > 
> > Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> > ---
> >  .../devicetree/bindings/net/onnn,s2500.yaml   | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/onnn,s2500.yaml
> 
> Where is the rest of patches? Where is any changelog or cover letter? I
> downloaded entire thread and there is nothing.

Hi Krzysztof

The threading is broken. And there is no cover letter. There will be
another version, so you can wait and review that.

    Andrew
