Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B773AB28E;
	Mon, 10 Aug 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378634; cv=none; b=jHNafQpq0yQfSQhCDdAERuj6fyOZcq/c86lGcV6u/tx0wR1Uf8dcKaOyHXyzRFpgttzp0N0+R0BpwFZ6Dbjy+7RMAaiegacu+oC/RcGZMGQVlKzNQnoP+WbQ3c+Ry53fJ09IN0vYQJ2d7V1g/BbkDBOcTd4WjjWHpq9iHjee1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378634; c=relaxed/simple;
	bh=nHDjAqs60zYrahzt+nKdZ75WY4hjyGhwhcO1BdaA+Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/4+sw46QE3QHrjGr3uxHnA+S2BLjdjush8XIOJhjn4HELBDJHq0njHuji+owcOU5FkDHDPWAmrQUpVQbaePhiE+6VH1MOe1WNzdZBrpBw22GGjbQhee5+J2rQTNv6gorySg+HtERleBu4AIBj7K8DDmtintXETvK2ZP57k9R84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QmIGRBUL; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xQB1UZzU; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QmIGRBUL";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xQB1UZzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786378629;
	bh=nHDjAqs60zYrahzt+nKdZ75WY4hjyGhwhcO1BdaA+Gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QmIGRBULpOH9EyTKKlgK2a2byf/gotpzNYPhpPs1E8xPZOK4/jEvANw+xbuZso2pH
	 ul54mFrRQ83GZM1Df0DFAJbjBA1nLW36mtyY66CkZtivBz3SDQhXeRx12SW5sX0OdX
	 UODtDIJzH9kEDNX0rUCVnNwRCMK1GCzx1q3PdS/AKHXK0ECY6grwanK6eXUuOR8ba1
	 v3rNE4Rl9RyrItTk/wClYgH9z+O1pCara2iP6GQasQNVJSb9W04fFAPZFXUvEyDZQY
	 jiwCUFduU82bnJNCiUpaYGBB2fOjqswV0NGlL92XjVr38wfZKXMTOAS286fs5CW/CD
	 9NfJch2K6q6lg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A6C4349784; Mon, 10 Aug 2026 16:17:09 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786378627;
	bh=nHDjAqs60zYrahzt+nKdZ75WY4hjyGhwhcO1BdaA+Gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xQB1UZzUp5rmzIKsYW9bUmwS7a0aaLe+CaSO/GMxs6Kq8OP2pm6MDBRcQStlX6rq9
	 1kMOcgTOmbmCP9KRdNx4wHx/qBFRX9FcX6gVmT7mCSD3JOzFW2VyWgF4GtKpQq97k7
	 Xy+Suevo3pu6YMFT+ZtMnGv03sKk6zGcRrbl9zD7YNhJJuFY0Z3iytYsA5qHCKS4kX
	 QMVx1RkRnivfy7qnIEH8SMmyYK+Fb++6ysCsVznxKjPMJscXIiaH0Lw8MaV3UVdg1V
	 HztWVGLHSAeg+Ev/EZmasw7tXrDSx7YydJzFuh5d7oaHEaji3moXyU6QqkmEp8eNAY
	 dUiWZq0O9StnQ==
Received: from [IPV6:2003:c6:9f06:3400:60dd:238c:9273:a789] (p200300c69f06340060dd238c9273a789.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:60dd:238c:9273:a789])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 20AD64977A;
	Mon, 10 Aug 2026 16:17:07 +0000 (UTC)
Message-ID: <904f166a-b3c4-4579-9614-6ebe3dc18277@birger-koblitz.de>
Date: Mon, 10 Aug 2026 18:17:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/13] ax88179_178a: Add support for
 AX88179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jianhui Xu <neuromoments@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <2eeb01b5-7d3d-425e-9865-4e2fe1614e67@birger-koblitz.de>
 <20260810013549.2510969-1-neuromoments@gmail.com>
 <5b2c4498-2e3c-4ae6-b078-deeccf8b7a5c@birger-koblitz.de>
 <60e05662-5f0d-4b2e-9646-f7d42e04ef13@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <60e05662-5f0d-4b2e-9646-f7d42e04ef13@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 15:25, Andrew Lunn wrote:
>> I have finally understood what is happening: There is a race condition between
>> the controller of the AX88179A trying to set up and optimize the link and
>> phylink trying to configure the link on the mac-side.
> 
> This is why i dislike any hardware/firmware which thinks it is smarter
> than Linux and directly access the hardware. Such features often break
> stuff, because it does not respect the mutex Linux uses to serialise
> access to the device.
The hardware by default uses CDC_NCM and even needs to be switched to the
vendor mode in order to allow any manual configuration of MAC and PHY.
As much as possible is supposed to work automagically. Linux support looks
very much like an afterthought.

> 
>> I will provide a v7 with an additional phylink function phylink_mac_interrupt()
>> being introduced as suggested by Andrew, which is called by ax88179a_status()
>> in response to usbnet receiving the link change interrupt. I tested changing
>> the link a couple of dozen times and it always worked, now.
> 
> This will make it safer, but might not stop all the problems. Does the
> PHY have LEDs? Does it have temperature sensors? Features like this
> operate asynchronously to link state. The user can configure them at
> any time. Such register writes might collide with what the firmware is
> doing. I don't suppose you have physical access to the MDIO bus and
> can put a logic analyser on it? Are there bus transactions happening
> during normal operation which are not from Linux?
> 
The device has LEDs, but they are entirely controlled by firmware. The behaviour
can be configured from the EEPROM. Writing to the EEPROM involves stopping
the firmware on the device. There are no temperature sensors, or maybe there are,
but the firmware hides them from us.

There is no physical access to the MDIO bus, as MAC and PHY are in the same
chip. I hope that otherwise we are safe from firmware interference, though.

Birger

