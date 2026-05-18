Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3131B830
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098556; cv=none; b=LK03bGf1kV0Tn0FoMFc7kmGbXBnf363m1692He/vT77aEYvrYuZ6uloFk6Rz4vvre86LjM7/jskc2HgGVavtK6gEPfhm6/pswwYjcOx/7rDrL7B6XiXgTYdFEBdZxXWui9OsT/UFwybI0L/2KIeUNBp1ESn9vhmW47QuTf2pLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098556; c=relaxed/simple;
	bh=DjPX0iLJm5HdjauSG8OjNGuHimq1+bp8IrsTjoCD3LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX21t4qzJ664T8A9P6Jc/7deLexDwweFRYH14vnUho6lRy5Ogf1DpTI8kORKbqyC39nYykAe9aMnBzH8AS763cx1ntR0s8n1b8Z5b69gIuPY+P4LVAF0/kAKTNJHCrIZA2n6NUZH/fWT8hs9mA4tUr30vZrImLRFB12zLQIxkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD1fL2/h; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD1fL2/h"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so2705243e87.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098554; x=1779703354; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN+YMmv9QnScORg4tpVq+mKnF6MQYSJi7uGVyTrlWV4=;
        b=TD1fL2/h/JDmVytPBKlmEbIzZ/Dpk62bFhV6+2iRmfzfshEjTd/haYYCVdG3UsywdR
         wrbLuuPsv2v11QawvNstFcr7lXxOXbBaRMGivqCtBbxYbqFxty7PUpwpbvY/x7thvPoM
         PHHgAxHx0RyioVEcNS9lX9kKZmDguqGHgFL//QSPR8Xi1SK7B5tqO7ibU/OtAXF3BJyw
         SVrEC25Xo3J2mKyVJYKx1TVY6gqsQnqXHE97HDLbNT2op5JveLnD6yUASETffD2x1nTY
         10loPMnHIRPWrvKQ473UjiLCbHMuKdoCeoD5Ih1C5mi6ns/XUR6xRsWHeV/qN2u4NYp5
         coTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098554; x=1779703354;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BN+YMmv9QnScORg4tpVq+mKnF6MQYSJi7uGVyTrlWV4=;
        b=PdFtlycqFO+C/mYgKrWvGdn4n9g0RSqepHKq05k4tepkAUf7ON4nA/kaGRNFhI7mYA
         B4bNIB17OEUCt8+MiYzhP4w7B0G4sF+dGDBRaqCBzK/8IAnsaQnhtNxj1PJRtroBN08g
         bohs6EvXsY/hzPmmbcMUOsbglW3CF1YdkZdlhsaz552xMEAR7BJJZTCCPim3SA68pj/s
         EZ2lXBKyduOv2TqZ4mPiEWIMV2CrPuICj/fT++DHPcuN2PWCKeeDT2hP3fLNMzjZRpcE
         VU+J5ImTT8t14cfeXcfKtHjkl2NW2YOjyzUOAO2BsAz/62XqsgRs9IdPcXd+raEYDe3o
         YcqA==
X-Gm-Message-State: AOJu0YyqbDM/pqUM38+HFjdgJAWPosullQNbHb2ZL/x5+4Jta3fAAnCN
	PgQZ+S5vGoRavq6KZeOcZtyfPOT/MdUrMAHnz0OLoEAPuYxLAUD1fxtJ
X-Gm-Gg: Acq92OGCjIkMn/+jLn+dH5AIzUtxaCfvYw498LnCX622ZkzPLtdiVjLJnpOYNqO4tvv
	5yyhSmTRk+uwuxYONJL1kUSqO8XMx6jv34s5vnoGr7wB3ufhEphBB2DJo/hUGCVHd24/DeL7JwV
	t4K0oj60P8pRuPQoCJUO7Ld2sjlCN3qKucWt4yHbcrnMtV8AynF2fY9fHfavxXmn7NkwkGkUV8y
	TNOMN6PEcNFq1o/XL6vf5UM9x0o5oLQDWV7YTc+JySjSRio3KeSg0PIdDFl3jwfHxz4vs0whPuo
	ghsMWIT4Dgncrs1d39BKwEQo9O3SZjER6+7DQA1xWUegx71K3WcZgA78h9F1TVLkcGmaSkAQoUL
	slZne1B65dfWivS9fThkAUF70BTLNc5rKIoD40+K9dI8DSE2dqfVbZuLciayTwhH9T/bDBU0FAf
	QyDccmO6rCAS+/SNF2QuDfu+3Q
X-Received: by 2002:a05:6512:3f13:b0:5a4:a85:ba3b with SMTP id 2adb3069b0e04-5aa0e09df5emr3864589e87.19.1779098552997;
        Mon, 18 May 2026 03:02:32 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a91e0ce644sm3193851e87.80.2026.05.18.03.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:02:32 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 373085A005B; Mon, 18 May 2026 13:02:32 +0300 (MSK)
Date: Mon, 18 May 2026 13:02:32 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v2] ice: Fix wrong dsn read in ice_adapter_put
Message-ID: <agrjuAlzsV0RqAwU@grain>
References: <agQ_xZUp3Sq905O_@grain>
 <20260517125307.287246-1-horms@kernel.org>
 <ago_YTTWiZs6G8_5@grain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ago_YTTWiZs6G8_5@grain>
User-Agent: Mutt/2.3.1 (2026-03-20)

On Mon, May 18, 2026 at 01:21:21AM +0300, Cyrill Gorcunov wrote:
> On Sun, May 17, 2026 at 01:53:07PM +0100, Simon Horman wrote:
> ...
> > >  void ice_adapter_put(struct pci_dev *pdev)
> > >  {
> > > +	const struct ice_pf *pf = pci_get_drvdata(pdev);
> > > +	unsigned long index = pf->adapter->index;
> > 
> > Is it possible for pf->adapter to be NULL here if the device was probed in
> > firmware recovery mode?
> > 
> > If the device enters firmware recovery mode during ice_probe(), the driver
> > calls ice_probe_recovery_mode() and skips the ice_adapter_get() allocation.
> > If the device is subsequently unplugged, the memory-mapped read for the
> > firmware state register might return 0.
> > 
> > This would cause ice_is_recovery_mode() to evaluate to false in ice_remove(),
> > allowing the normal teardown sequence to proceed and call ice_adapter_put().
> > Would the unconditional dereference of pf->adapter->index then cause a NULL
> > pointer dereference?
> 
> If we're in recovery mode the ice_remove will not reach ice_adapter_put,
> instead it will stop service work and just deinit devlink interface, no?

Thinking more I think I got what sashiko meant here: the pullout of the
adapter when it been in recovery mode already, and reading register state
is obviously incorrect here too, instead we have to save the state upon
probing in some flag and use it later. I'll update the patch.
