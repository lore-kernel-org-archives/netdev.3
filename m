Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1C3AE19D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450914; cv=none; b=KVQGvn+fyXSsiFn1ULp2WTNrd7L8DHDnRUdJsG15fR7kinegKJ852j4bp52DPq83s9zSNBl07s++fgdXCKSr9x0D75NOjNBu9hc5gP1PPwS6f6pgaiSkVc6UNc5FzINy4U0kBQNrPcwGddVQn+D67ME9YdiRC6Onf/caXatokxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450914; c=relaxed/simple;
	bh=+9M/cFtsoQyfrNsQ9FS6t3KvUfUQVhNH19LJXrEpyQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivs+frxR87rplESDciu0KjmP0itCixJ+yP+z9VtadJ9XcDTSK+hWXwe2hE+MV5ulYSQAG+v9FZ6cW7BzxKVQlKZ7N0/0W/SkHKyeCJZt6sMgU+SmWdhvp6kDKQzp/4cPKNFoyq36vvbvhGVQpXoFx5imeWfQIPLFeIDc/sOOZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=Fb/y27gv; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=M/JCgXdB; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="Fb/y27gv";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="M/JCgXdB"
DKIM-Signature: a=rsa-sha256; b=Fb/y27gvpwne4EMiKYSKktrm0zoxQw5w0qdKlxYj1PsjUQTQZg08WCD2x8K2Wiu/ud23xcJFAx025119TI5Y3wY6Tj+20NFYrRg+ebAPGh+cxcCS0j6o8nwlcOU/GQjDEAQwJoCCJ1S8Gysg9OHGXWvjKSYb/69+Y6fKvvbLNI3tbckdMZvbIG7vh3pm0u7lndpYYuisnkMgOYrEW0TU5WcsatAlWBVnU5RkDZmD1/aKuN9II45y60EjaZxYkuDqLrnHm5X6sJiViiDrd796RC0ksVqK5J3HQ7Vhcs0MDc2W7BkvTZ5RgcriYEA+VFuwVUmUV02uXQUKGkhp2DFCIw==; s=purelymail2; d=tinyisr.com; v=1; bh=+9M/cFtsoQyfrNsQ9FS6t3KvUfUQVhNH19LJXrEpyQM=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=M/JCgXdBvOifLu5hevyQhNXc9XuInd1Hb0cv6pxFLy/VS2PAkaG4uL+tB89UfjLqaSvu+9Ua6Kv3EzZwlaF1mP/qCf0mPhASLukJUyRFSidEqH0bKq1j40XYInMymJilBuedM7ZwbE5uMYB37qKwgzv8Bx+bprBG3P7prrqy2XP+o89wU5NpVeRXR0uKdAcLSBjuYB5Wmfz1HORKQQvraHpVTsm/tFuPukMUXOPVzqLvh767yB1z8uDRt552lacz45ll0nGCA10Pp4Ndvvylge3f4Qq6bgC+Hau65/yvCBUo3dMWa/lrPAUDVtWfFJA11IuMR8p/PydxlARKrl7v9Q==; s=purelymail2; d=purelymail.com; v=1; bh=+9M/cFtsoQyfrNsQ9FS6t3KvUfUQVhNH19LJXrEpyQM=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -650336061;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 29 Apr 2026 08:21:44 +0000 (UTC)
Date: Wed, 29 Apr 2026 11:21:30 +0300
From: Joris Vaisvila <joey@tinyisr.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v3 0/4] net: dsa: mt7628 embedded switch initial
 support
Message-ID: <afG9uaP_zWiWMdq9@archlinux>
References: <20260428185510.261521-1-joey@tinyisr.com>
 <20260429-impossible-archetypal-bear-607a7b@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-impossible-archetypal-bear-607a7b@quoll>

On Wed, Apr 29, 2026 at 09:09:44AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Apr 28, 2026 at 09:55:06PM +0300, Joris Vaisvila wrote:
> > Hello,
> > 
> > This patch series adds initial support for the MediaTek MT7628 Embedded
> > Switch.
> > 
> > The driver implements the basic functionality required to operate the
> > switch using DSA. The hardware provides five internal Fast Ethernet user
> > ports and one Gigabit port connected internally to the CPU MAC.
> > 
> > Bridge offloading is not yet supported.
> > 
> > Tested on an MT7628NN-based board.
> > 
> > changes since v2:
> > 	- fix binding issues found in review
> 
> Which issues exactly?
> 
> This has to be specific.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof, 

My bad. These are the binding changes since v2:

- Removed description from reg property
- Clarify reset descriptions
- Added ethernet-ports to required 
- Fix reg coming before compatible in the example
- Replaced 'ports' and 'port' with 'ethernet-ports' and 'ethernet-port'
  respectively in the example
