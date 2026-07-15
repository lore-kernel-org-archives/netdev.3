Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D23370AE2;
	Wed, 15 Jul 2026 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078293; cv=none; b=BGmJ8y7UvAFZt5Ejz/p+yVfXB6aKuOoAXiJAE6A5X6bpzLeheYGcekXFvO/1rOKF7AP3btNnQSjzDgNDrxnYIsnScrGucPOVhgwYPukuHG2IajJU9pChldVmZzdGbbSZ0r4IbwWuit3SLlycvSUEEp6udodJ+isPfD1uezQAnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078293; c=relaxed/simple;
	bh=4sPQQ+IEd914R5dwKvabSA3zvLwLb32nOovGKcRBffk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwsJQLR+F2OsvrO5we1NVTUmbQFcNlXigO0MQNrthXffZ9oI/1xb3txmiqE0xPIZFKOZ63WabERyYC/j6UlklrAULbGxX3XUbH+G0F/i/W7yozXryaa8c8Uq6miPM2eM3I25voKw1NILkHFX2vbsidRsQHZfW40qRjr9qI6agjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LNHkyM8W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LNHkyM8W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YZynQIW1JzdW819zehowAqA6nIpmYaa+6vOhpBfdmqA=; b=LNHkyM8WrI2t1x4KV7lQJD2Csp
	Eh5Z3Pbhf+dPtzZDPU6HYULu3Asxkz684u8ci8UK46AsSl7+ToCilOjkxH8/wHCxrvfPGr1dvObLi
	DF23cdQjZ+zzDydn2YoRMId5Q6qeIW9ylX4nB8XWx9W9+lJuq4XfgGF8z4LxEhAT0oss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjoG8-00CHLH-Gl; Wed, 15 Jul 2026 03:18:00 +0200
Date: Wed, 15 Jul 2026 03:18:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, manuelebner@mailbox.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net-next 3/9] net: usb: usbnet: add cdc_state to struct
 usbnet
Message-ID: <ee6c537e-32e7-48a3-9037-49ef15ca7603@lunn.ch>
References: <20260714114429.1073434-1-oneukum@suse.com>
 <20260714114429.1073434-3-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714114429.1073434-3-oneukum@suse.com>

On Tue, Jul 14, 2026 at 01:44:23PM +0200, Oliver Neukum wrote:
> This allows centralisation of code using cdc_state in usbnet, reducing
> code duplication. No functional change intended.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

I gave a Reviewed-by to v2 of this patch. You are supposed to attach
them here on the next version. b4 collect them and add them for you,
if you use it.

   Andrew
