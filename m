Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479682DF142;
	Fri, 18 Sep 2026 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696754; cv=none; b=V1uFjw0rldtQv2eL9XT7hD3M9z9fwVLjsOolEuy3tnpzfzcvzd0E1/zEf4R3Whb/+MRMegS3cm+cY9Q6wOcxzyE+PFr1FhmKYi/XZ5R0NIn1B3GV44FxKJjatPRA0+wiugjNswAXV2vdhtJyvbiLOmu5DjT6z2MsxSuFksScdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696754; c=relaxed/simple;
	bh=uGwV8+GYzMKjQS0cWOxbIUzVeDpOeu6adjeGErPcBW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpCVdo69zUjZ7tev7+E1poeDq8flj6OmljKezxiTt9+M4PLnh0J3Fa7PIeP6Ei1JcYcIZRd+myyYKCD65CISTJ2rRsTJHnXRRz5ml8HlU9POIYCfsulvFlT/XgvGXERMCI1OXoAEPmHHarX2MHK7q1zIvBetmAEU+5XLFAi3IeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zCbGHofA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zCbGHofA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jRqUyT21EROagSJqRyUwvTzzYL2dWUH+6wFhXqmioP0=; b=zCbGHofAIpiptv8bWoX0a9Ci1y
	0Y299WZOgc9peOdcYY9OLuZ4lMPezBMd8eYIIwvb4oG4QlRhfEo4lk870ScOXpZ9N57FNWCVRvnNX
	YmdyteZdRQyBIcwXoT3WLjG6v4pKNL4c0M9UWlJn5CPOxLIs9Oab6/sjNdkDgK78EIXw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7NsH-005mZV-Sq; Fri, 18 Sep 2026 03:58:49 +0200
Date: Fri, 18 Sep 2026 03:58:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com,
	daniel@makrotopia.org, olteanv@gmail.com, gerg@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 1/2] net: dsa: mt7530: fix NULL dereference on
 unbind of MT7531 and MT7621
Message-ID: <857a7395-4741-4d2c-abb0-b806e8f9bd78@lunn.ch>
References: <20260918015020.2518315-1-f@lex.la>
 <20260918015020.2518315-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918015020.2518315-2-f@lex.la>

On Fri, Sep 18, 2026 at 04:50:19AM +0300, Aleksei Sviridkin wrote:
> The core and io supplies are only requested for ID_MT7530: both the
> devm_regulator_get() in probe and the regulator_enable() in
> mt7530_setup() are guarded by the switch id, but mt7530_remove()
> disables them unconditionally. On an MT7621 or an MT7531 both pointers
> are still NULL from devm_kzalloc(), so rmmod or a sysfs unbind calls
> regulator_disable() on NULL.

Did you consider using devm_regulator_get_enable()?

	Andrew
