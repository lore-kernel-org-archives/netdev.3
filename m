Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792474849;
	b=0fOYBqrTVpRIgaKkWTzsrpIFKMfZsAvfoxTB6WSzb0KEmzqD0ofdlBHVXiHMlOXS0StL
	 q3AH0cgt0FDO+88s6rJaDzX/023xL8as/+WKP8s2ypIUxY6scd5T6QfhPacHCah41gQbG
	 Q2wzEFqs/nTxJBjlOzLz0/I27dZvTBmdcBOUpreQvu9oW9eTFcqST6/AuLLqeor0etV5u
	 TlDluqBtXvpHJQsDwjKg4DkYYqQOSsMh5wgGNqfHmweEaJAK5KM58NHFn2wu8f8uF6FNN
	 Hm/IrNd31VRz4FfmTY7nnplSk9Y1R9iPv03jHVsBmVm3Au+Oq2JclqwLp5hIq6FXIkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474849;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=gl8OUi5kGil7GVVr3uKIin4pJiUyLxB1/O7d9fmIcws=;
	b=wdFxxr3ZrhR66OU9He8KiAgSkL8qZtnPFw8nYBchF/AQWZenvlp7J2KDVrnNksSRkBOl
	 VsjQfFPxULs0mQ2QYxHpSRwgUP+eB8R609cWCDsJcMUHZp2XRKNHz9pJKRb0l/+Mx9zLj
	 /qL4RP9LiagkU2PjSuvi9O6hqG+258ldp50GhaQ0i7KZlNk/X4RCkK5KscR1xAurOnq55
	 MsYjyZDJ5VPvhP2/0CmOnanu8Mqjg0dpCx+BVNFJbhbUaeLvMZUMXJk86UvV/lam17bi8
	 E5tRhRJlydBZIteFZwvjsoyWFNXluLH8kbFj+9dG/S1znlK2OgpYIa0o5nW8HcPD14Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bQZk+xq7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B43606A319;
	Tue, 20 Oct 2026 05:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B43606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bQZk+xq7
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1D0B2201709;
	Tue, 20 Oct 2026 07:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792474845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=gl8OUi5kGil7GVVr3uKIin4pJiUyLxB1/O7d9fmIcws=;
	b=bQZk+xq74fwC9zq8UroJBR7N9b7OMq1CgWepbLdFIHDCKF3i2AXLLJKS4gqDwCMsPW4dXK
	4iEzeXUBS3xTqsk1YLYl4G1yY0Klxw8b4GJYenY+lSDmzsNCV5ebfSJrEmIbFjSt61SIn4
	uLwdyPAR1d6ZuVg8OW51z+mnLf4HGiH3ENS+JCld/bdq8dqS+yWiiSP3TATOr0UeTar9go
	HUiDQ/EJtjNA4CXkikaSFHZ2rx7vS+xwcOnk0ci5T1AJ6LhE2XsUgt+4/E18Yc6xseoSWD
	82WmhAf4WlpyFfLE0afqzhnjXmwjM01cAcnNzyITWagX8sYWo1RvJoM4vzGVnA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792474845; a=rsa-sha256;
	cv=none;
	b=B91ElkoeoRGSwhhQ+nrc6zSBq/u1PZMT/Nm22wmHELJJjd/koEambypwj3/gvfGLqZC2EP
	lKHuCWauYXTtUuSLnmNev0VS9i2AigejwzQP9tinjKFour1YNXWNumVGClE/+w3woPLCAB
	sZGicGNHX5h5U8cgSM0aKFKXkelzmhvWBl60MpGmS7uI1MAeb0CFPR/M8AkF8QdyB+sUgL
	PMq2rZk+6BSyE8QJ3pxKJxgLzJDyvvaoEbXXBL1xpWhA7O3kH2zDHNJN131obIcusGILu/
	fcnURsn1dLuT9UyUB4IcaTgn4gvMxPSvN8rtkFhjkbCu4EkZrAI3bwkveke/NA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792474845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=gl8OUi5kGil7GVVr3uKIin4pJiUyLxB1/O7d9fmIcws=;
	b=QQv337OO7HI/TRkS71rgAZQO+DBgkxaY2N4DkfYar5rcYdJQcp++mzUgTv7xZxjrdwY0gK
	MdyF3BbOOXnv86kkaUuQoos1PrXke4Uj3O26UfJbZ4iebkBgOKoI26zg0ZPElNmAgAdz0N
	uJ2zSYZBOpNKKw5v1CAXdXQi/Jtk4YgHku3sGty1YNymfaerjKU1rFvjO9KgIFqn/Gk1KN
	pWtM20FropYlyrggrRRQtKqtL/2eEdtLx/jSGX4JbCbPeKXOCqdE6b7S4VHQVdI4kaSGT3
	mfmEXViFtepPJDLdg4ZHa6nI+tnUt7moN8xIYPUFTcA4UxMWPFD9H3zeXI4c6A==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJ2ab-000KJi-06;
	Tue, 20 Oct 2026 07:40:45 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJ2aa-00000003kKd-3nb0;
	Tue, 20 Oct 2026 07:40:44 +0200
Date: Tue, 20 Oct 2026 07:40:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, github@szelinsky.de,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, piotr.kubik@adtran.com,
	saikrishnag@marvell.com, horms@kernel.org, kyle.swenson@est.tech,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, broonie@kernel.org, lgirdwood@gmail.com,
	mazziesaccount@gmail.com, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net 05/10] net: pse-pd: check the PI state under the lock
 when setting a power limit
Message-ID: <atb-3EIJynaRwuwe@pengutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb8eaf92-2b5b-46a1-b39d-a29ae273a3b5@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

CCing regulator related folks.

On Mon, Oct 19, 2026 at 02:30:24PM +0200, Kory Maincent wrote:
> 
> On 10/19/26 10:51, netdev-bot+sashiko@kernel.org wrote:
> > >   	previous_pw_allocated = pi->pw_allocated_mW;
> > >   	pw_diff = pw_req - previous_pw_allocated;
> > >   	if (!pw_diff) {
> > 
> > [ ... ]
> > 
> > > @@ -1908,21 +1920,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
> > >   	/* Update power budget only in software power control case and
> > >   	 * if a Power Device is powered.
> > >   	 */
> > > -	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
> > > -				      psec->pcdev->pi[psec->id].pw_d) &&
> > > -	    psec->pcdev->pi[psec->id].admin_state_enabled &&
> > > -	    psec->pcdev->pi[psec->id].isr_pd_detected) {
> > > -		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
> > > -					      pw_limit, extack);
> > > -		if (ret < 0)
> > > -			return ret;
> > > -		previous_pw_allocated = ret;
> > > -	}
> > > +	ret = pse_pi_update_pw_budget(psec->pcdev, psec->id, pw_limit,
> > > +				      &updated, extack);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	previous_pw_allocated = ret;
> > >   	ret = regulator_set_current_limit(psec->ps, 0, uA);
> > 
> > [Severity: Medium]
> > The scenario in the commit message, where budget is reserved for a port
> > that is no longer powered, looks closed now. But can the budget and the
> > hardware limit still drift apart in the other direction?
> > 
> > The state check and the budget change now share one pcdev->lock critical
> > section. The hardware limit is still written in a separate one:
> > 
> > pse_ethtool_set_pw_limit()
> >    pse_pi_update_pw_budget()        <- takes and drops pcdev->lock
> >    regulator_set_current_limit()
> >      pse_pi_set_current_limit()     <- takes pcdev->lock again
> >        ops->pi_set_pw_limit()
> > 
> > The threaded pse_isr() only needs pcdev->lock, so it can run in between:
> > 
> > CPU0 (ethtool set_pw_limit)
> > pse_pi_update_pw_budget()
> >    sees isr_pd_detected == false
> >    *updated = false, nothing reserved
> >    mutex_unlock(&pcdev->lock)
> > 
> > CPU1 (pse_isr, classification event)
> > pse_set_config_isr()
> >    isr_pd_detected = true
> >    _pse_pi_delivery_power_sw_pw_ctrl()
> >      pw_req = min(pi_get_pw_req(), pi_get_pw_limit())  <- old hw limit
> >      pse_pi_allocate_pw_budget(pcdev, id, pw_req, extack)
> >      ops->pi_enable()
> > 
> > CPU0
> > regulator_set_current_limit()
> >    pse_pi_set_current_limit()
> >      ops->pi_set_pw_limit()         <- new, higher limit
> 
> @Oleksij, Here is another example of an issue related to the PSE PI being a
> regulator provider.
> 
> @Carlo, Kyle is working on a series that remove the support for a PSE PI
> being a regulator provider. We will see where it goes.

Removing the regulator provider support is a bad idea:

- We will end up implementing a poor man's regulator framework inside the
network subsystem. Networking folks will have to deal with physical constraints
already solved by the power management community, requiring a different mindset
and domain experience.

- We lose built-in regulator infrastructure: DT safety constraints
(regulator-max-microamp), over-current/under-voltage notifications, and
sysfs/debugfs (regulator_summary) visibility.

- The race above is just a lock scope issue across pcdev->lock and the
regulator call, not a flaw in the abstraction.

- Writing a custom power state machine in net/ will introduce more bugs than it
fixes - especially if we overestimate our ability to upstream complex custom
logic under LLM review supervision.

Let's fix the lock serialization instead of dropping the framework.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
