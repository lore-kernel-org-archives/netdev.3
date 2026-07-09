Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E23603DA
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607857; cv=none; b=t59VBohRu+uG2wagpjFYvfsZLf3usEmZfZQ6mmJhDNW75670V4UHMR5tV/5CXKYPUlAAKqMhDnyHHOzGKYl3FpuNCMZaEQEA1VaJJlRwPaJNvv0Yyc2RQpT53po0vHybneUTzwvOQ9MPyQuEKHtnwJtUGeNc5lNDw8aI5rMFBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607857; c=relaxed/simple;
	bh=oFdux9olTbDu52t6QGsMu1O2QLGU8CBbh14drLn0XEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEhNm1D9hVw9qLSXw/sNTVfD0o8sOXhVXb4VIancpm6nslo+EqsfItErZjfMILK0w7eOK+U5tkUBs+W+aH8Rnm9GqocWrqn1R1V5MP1lOjjDowDQD2oZ3v25NDvjzq9+JFFz57UEpOPWlHsc1rC8KnB5a0XZgnUIbCbS1ACg0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QpxRgfb6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QpxRgfb6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xabDU/adk37A6YmmRSuBPYUcK4Xa2ZqHdjt8F7wVQA4=; b=QpxRgfb611u1vS0qwWjcB1BXyd
	h+fl60knU8uQxLyCLtaCj7WwChyJdhd8gGi3n/z7GqKNHTEGZ6ZCMXTrUx3fhnK8AgEMKoW528m9n
	DkmxvzD5Jj5jS3svANZf9e+Drg4tQ12bx5JRiX/7HhGZ+YcZgYkS6GjXeEOkl/3URhfk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpsT-00BVi8-Sl; Thu, 09 Jul 2026 16:37:25 +0200
Date: Thu, 9 Jul 2026 16:37:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Trager <lee@trager.us>
Cc: "Das, Shubham" <shubham.das@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <4ccc869f-a724-41fc-9bfc-da5332f54790@lunn.ch>
References: <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
 <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>

On Wed, Jul 08, 2026 at 05:58:52PM -0700, Lee Trager wrote:
> On 7/7/26 2:06 AM, Das, Shubham wrote:
> 
> > Thanks Andrew, Lee for the feedback.
> > 
> > Lee,
> > I don't see prbs11.0, prbs11.1, prbs11.2, prbs11.3, prbs13.0, prbs13.1, prbs13.2, prbs13.3, prbs16 and prbs32 in IEEE 802.3 2022 standard.
> > Is this specific to fnic based on base PRBS pattern or it is mentioned in some other standard ?
> Those were from the fbnic spec, I'm not sure where they originate from. I
> suppose we can drop those for now but its good to keep in mind more tests
> may be added in the future.

Can you find out what they actually do. It might be something as silly
as, the .1 indicate it only runs on lane 1? So these are in fact
standard prbs11 and being able to specify the lane via another
attribute is sufficient?

	  Andrew
