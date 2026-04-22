Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2024A23;
	Wed, 22 Apr 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859898; cv=none; b=uN4UP+D4477cuSiV/OGdJFqWjQOYVygYOZsFzmG2X5HPw6QtFpWE8CjN0UO0ibTtzN59+a8q5Xw5FGD5Kdprh1yfJ5AsyzH2o/4OEMz0+Lh6xmVyLqzQntUVTsNIhqIARnkjRVr+EwG23ByUjpriV3F2bQIYN1vDjZT36TSdw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859898; c=relaxed/simple;
	bh=YT8haYI8XS2MQJILurZdGkxMSnRIN7APYYc65MHlcZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si6TXfBGC/7Wza/kQjNkA4uBo4pY8RjlEkXnr4iYS3DE09oTjfqcCRhzQLCNtUDBleTWPkk+wu+APqSVj2Fr25ECjE1GY7U1Xq5TwraZ2Bi7tuAdx9SCcJLX0+KuWAIj+p2T4IWhCcxJ/oUWmxzL/xpaG6gos2CsqSoKO2ATey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qL0Fc9pV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qL0Fc9pV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eBOvVaY559eJWvihmMmWLtX2bTxuOVkdHqvg1r3GvRo=; b=qL0Fc9pVOZDHZdXf/ENfep1bj/
	m8PiVHtuqE7VwlgIjQBNOnkKaq6OVkFp18salx4h1mpNr9iVK6+jhbGqHTDwrKB7kn7unB3dFsIV9
	ogeto+nupVrGOP+FiHATB5xLnqz4fXTbGytwbfrD1nAdqHgdl0Y+Uj5JpXay72kcVJZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFWQO-00H1jB-Nf; Wed, 22 Apr 2026 14:11:24 +0200
Date: Wed, 22 Apr 2026 14:11:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Byron Stanoszek <gandalf@winds.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <41d9fe43-9aa5-49b4-89cd-9aa13e4e4ea9@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <71d319ef-cd49-e8a8-70dd-cf0763ac6305@winds.org>
 <e056d348-4560-4df3-85c4-e29393b004e9@lunn.ch>
 <9a0bc592-fb74-f646-1752-4359c0ac31a2@polinggroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0bc592-fb74-f646-1752-4359c0ac31a2@polinggroup.com>

On Tue, Apr 21, 2026 at 11:03:28PM -0400, Byron Stanoszek wrote:
> On Wed, 22 Apr 2026, Andrew Lunn wrote:
> > 
> > Could you live with v6.18, which has an expected EOL of December 2028?
> > If you are only updating once per year, security is not an issue, you
> > just want stability.
> 
> I could for the time being, but this hasn't worked for me in the past. Usually
> what happens is the PC breaks down, and the customer swaps in a new
> backplane+SBC and moves all their PCI cards over. I then find I need to update
> the kernel just to get the Intel DRM to work properly on the new CPU. Some of
> these systems were installed back in the Linux 2.6 era, so I've gone through
> several "Intel DRM not working" steps ever since CPUs started getting
> integrated graphics. 2028 will come fast.

Hi Byron

I will drop this driver from the patchset.

	Andrew
