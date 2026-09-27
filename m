Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94292F3614;
	Sun, 27 Sep 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790500830; cv=none; b=YgCl5jRPnsn77YhbRuY7rQyYTK/y+kpdCxPHNvaWPNRdqWeJL582tGGq89zIM0+iOeMtVvivCPw+bkNWtsUUavBLAxeKRnWLEKwiGo1nzgzfIdNdDOCsuF6Sm+FmjdX857GyGYUQWYuhCl5CI2BL8yWxQ70AZHIIRJbo/A0WiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790500830; c=relaxed/simple;
	bh=fa2rmoi63w+g+kYJBp2yUyWM2MM4yVhuvkElmM2otPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guVsBA/5T7q0nsAA5Snlm/oxw39PDe09wSY8/1tBPMgylUQpFXThioKlDV82DHsZXRX9+zNqHQXwpKhoxi6tccrVcdH6zUTL73mK8vKF3QSAfSfS//UCssN/AcD4aoBuk8XeA/OeqtiRXPWXVfm7AxhWmNuJhVZncN+1sADpuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=V/Pw2dC0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Hip7iab4; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="V/Pw2dC0";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Hip7iab4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500828;
	bh=fa2rmoi63w+g+kYJBp2yUyWM2MM4yVhuvkElmM2otPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V/Pw2dC05QydmFeTTrFmCBDVikmUQSapOXXsuohKPHkuGFhyWmBQkaUT3MmbgHNMi
	 zAF4N01iK0qIYumUrnzXEwvxMAsUafqH6K4XFoFlRb4oMIAPi4k2SlVsdLU67zqANA
	 QTqnM9lsP//DKeLpHbM2NcUUZZgD4p0qlJESoJSq4ROf4NA5/dXCcBKWkTMQWoaxeG
	 XYjrM2QBEaPnXdPBZ16xfzbrgjwaPyIDab4jJRxeuUbm+gjQufKYY2FDT5UbDZvKmK
	 l4l3kcqMlaywtd6EEkCYxaHvXFT7cKG5mA7FEQ6b4cFQ3ft47ZJcn8JFYBtE8sj0Db
	 VbO/9W7LCgPFA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 067154130C; Sun, 27 Sep 2026 09:20:28 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500825;
	bh=fa2rmoi63w+g+kYJBp2yUyWM2MM4yVhuvkElmM2otPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hip7iab4kmxw/48sEziGskVRB544+DmaQt4aR/LvbrcGOWGtOm9387XCEarNwPLOW
	 EtDkStLiU7d0bO2eTOkVr/9/xRyzfWn6saX7shoXVFaN/6gkQ2rif6ilLwvoX4Vwrz
	 tvr0aKGCEKSwOcTxIllGDXRIV4H0Do48A/O0xnNeejT4AHhJeY2+ECh4FEVXYFkyGd
	 eSm3YRmyD/IvrJaadRjYgOn4OI2KjYyjfRMI1FTDpbEGSVZfYt2BdI9V1SxW/+RpXR
	 sv+IssedZPD16ejOluvHDOFRWNJBSBPnrjPtRZEB4KhK0Ki2gMUCjOuYPXfU43/+iT
	 yb2HBwo3SDXZg==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id AB607412E0;
	Sun, 27 Sep 2026 09:20:25 +0000 (UTC)
Message-ID: <40645ef3-af51-4471-ad75-51e43033d8ea@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:20:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-7-60c04c9924a2@birger-koblitz.de>
 <178968029831.22033.7070310020914026845@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029831.22033.7070310020914026845@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 3
> 
> - [Medium] The AX179A EEE control register (AX_GPHY_CTL /
>    AX_GPHY_EEE_CTRL) is never forced to a known state, while the driver…
Added setting of AX_GPHY_EEE_CTRL to disabled in ax88179a_reset(),
consistent with phylink default.

> - [Low] In this patch alone, ax88179a_phylink_mac_ops gains
>    .mac_enable_tx_lpi/.mac_disable_tx_lpi while ax88179a_phylink_setup()…
Not relevant as further functionality added in later parts of the series.

> - [Low] The changelog of "ax88179_178a: Add EEE configuration support for
>    AX88179A MACs" ends with the truncated/incorrect sentence "Add support…
Commit message fixed.

> - [Low] At this commit, ax88179a_ethtool_ops
>    (drivers/net/usb/ax88179a_devices.c:209) has no .get_eee/.set_eee…

Not relevant since the further functions are added in later parts of the
series.


