Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DF330644
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394416; cv=none; b=RF0ahLJaZrZ9QYCVlQK4qHwA/7D1qO6Xu669k+qO+epczHc12OyfWJNixj9n6ic1yC9wwPoQZLkue0Bf01/0Ba6Zs+AYL5ucFlNMGAITXzcxWGlLezHqeBaQeEDytRDERZz0ckZ7hpP4qEbE6l1GJ3U2lTSkelu/a+09MSF7ldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394416; c=relaxed/simple;
	bh=/H/qYEml20skAVQTa8A0yHC53jjrmwvl6PPvPrmVfy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHmgyJ0UKfYd+e1kMHwavaUfqXiOm0XOmiCe3LuIW2Fe9aoS8htIeb4JzirkyxPlpF7syIfcoh2HFscfVt6wx17Z8dbv2e2mg8yVEhnKCQakWjV+joyfLOdPouFp8O47yyZCi5sBonCLaVQqYp4eMUj7mjitTsYJBNAMoIu7HsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KKe1Fh4r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KKe1Fh4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eKhg67p/Q/vgzvwHgsfFuYjbdk49SIaClYWCRzGtz+k=; b=KKe1Fh4rrJ27mEZWOW/03Womj+
	1lJqc7r5rddVXbTIV9NHYzMU6tKvIZEEcWe7+FVD1cHTa+3d8Sviza3CkTIch0iIsGV4C0MRJc+H5
	5Bg4RXbNFm/pO+9c15m5ZdYvW4lKgWmMPHJNf6Rqma35vAAupDRZ4srAE4klSZTXEpEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHlTk-000NIk-6r; Tue, 28 Apr 2026 18:40:08 +0200
Date: Tue, 28 Apr 2026 18:40:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Satish Kharat <satishkh@cisco.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Recommended local LLM-assisted review for netdev submissions?
Message-ID: <6fb66176-a20f-4d6a-b12f-f15b95189327@lunn.ch>
References: <20260428151755.1310712-1-satishkh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428151755.1310712-1-satishkh@cisco.com>

On Tue, Apr 28, 2026 at 08:17:55AM -0700, Satish Kharat wrote:
> Hi Jakub,
> 
> I'm the author of the in-flight enic SR-IOV series. Before posting
> revisions I run checkpatch --strict, make W=1 C=1 on touched files,
> scripts/kernel-doc -none, and `b4 prep --check`.

AI reviews is the big news at the moment, but please don't forget the
more mundane testing which also gets run on patches and series. You
can run these locally:

https://github.com/linux-netdev/nipa#running-locally

	Andrew
