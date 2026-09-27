Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0D346FA0;
	Sun, 27 Sep 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502027; cv=none; b=eiQvPXK6ahVW0YQIImjkQMKjkVpwYRutT/o2/e0XZLtNN+wFhV6GYcdTjGcMFeBBtd1cG9PyENnHPJeFB4wG6soA27KocJRxxVEXxvGQcWEx+vtoVgysIp/HoB/a8ZwqRh519jy/NFn28UWUouDO4vZoNpA0QplSV0qhWvGLNLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502027; c=relaxed/simple;
	bh=C4dr4AceHCcfrxnX6nW9BTvD5zx5ZCyPhjchftk1IAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyyDbkMGsKfAl5u+6LyeLpEv1GrIC/ebX6qVNB3E2YjI+o2MrMxv0I7P+fT1ZrFCZZmmg6CQownlWGi0iJGlP6tNi0rpfmqsjyggM7TEXMqOK7Vgygr4bqbeOKmZzitWluVLWjiP9Ehk4MeFm2aReDgEytMeBHqz4fpPn5v6ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WWi+iD/z; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=3Cc7KP4z; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WWi+iD/z";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="3Cc7KP4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502024;
	bh=C4dr4AceHCcfrxnX6nW9BTvD5zx5ZCyPhjchftk1IAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WWi+iD/zCNfaTGbfbe/FzGv+Q/NoTnCe3cllMQfOntDXB0lIDlUK6JQVGnoERhje6
	 rTkm8lLhWXCEgQoKxxdYA88E6POq+/ULIJp7Ry16sCl4pFkAAbq/xqgRc6wGdQkgQ2
	 t71vYri3be+qnx9ozwJ6boRziiI1KoJwmKT6ZH7ENF7uc/reYZM5FuzkpZj9HmfVZW
	 MYWO5l1aKEISKUL/PQGti+dYXm3BiiGLL5fBD8SIUNF2bDG3TljZhSB3PcEd4cNta+
	 qHNina+5ZoRVvqv3oGDywtgBTUbPZZV7wMP8LmqQfeShIqX7GPNOayuXGA1vwkp4Uz
	 6tBHEGUR2uJfA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 41C86412E1; Sun, 27 Sep 2026 09:40:24 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502023;
	bh=C4dr4AceHCcfrxnX6nW9BTvD5zx5ZCyPhjchftk1IAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3Cc7KP4zSyDe8Wui6AC6e7AQqFCbG/ux9uNrJ8Gdq2FdR1yTxCrJBZth2bzC6k9vr
	 mjvEdLLZ+e8lALQbcBzXa6SvtZveHL4TXSd607Uyr9Xx/Hh3Apuiv4Er9WE//JdBoh
	 EiFyMobSbrJpS0crNJynf7yiY27otTYGrMtqto66y9H9495ToZ/S2OHtQ32Mog2aAz
	 pvJ8lvkTil1Chk2gDzO/B/p75SnKtYD0OhIHtU/mJRtlv3rJ8w4VlAgt3t3HLmDjq/
	 s7m2hf3EGd8o2KEr9r8U5gRpDv+HrOtjWzq+Y+BzbLcXeSPRlYTx453klurdHjYXzZ
	 igDufJOT/4k3w==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7BB50412CD;
	Sun, 27 Sep 2026 09:40:23 +0000 (UTC)
Message-ID: <2a618453-f9af-4595-a97a-7c5856be7fba@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:40:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 14/15] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-14-60c04c9924a2@birger-koblitz.de>
 <178968030755.22033.11537311081987859211@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968030755.22033.11537311081987859211@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:25 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 3 · Low: 0
> 
> - [Medium] The patch smuggles an undisclosed RX-path repair into an
>    "EEPROM access" commit: `ax88179_bind()` now sets…
ip_align moved to patch adding HW support.

> - [Medium] `ax88179_eeprom_access_params()`
>    (drivers/net/usb/ax88179_lib.c:197-214) picks the hardware address…
Will change the gating in ax88179_eeprom_access_params to correspond to
the eeprom_read_cmd/eeprom_block gating in bind(), i.e. use
else if (ax179_data->chip_version == AX_VERSION_AX88279) .
get_eeprom() changed to reject reads from chip_version > 
AX_VERSION_AX88279 to prevent the use of the AX88279 access 
configuration with future unknown devices.
As for hypothetical legacy devices with chip_version > 
AX_VERSION_AX88279, they do not exist according to the vendor information.

> - [Medium] `ax88179_get_eeprom()` (drivers/net/usb/ax88179_lib.c:237-249)
>    only rejects `ret < 0` from `__ax88179_read_cmd()`, but…
> 
Will change to  (ret != ax179_data->eeprom_block) to detect short reads
