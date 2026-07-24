Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25341BA7A
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905456; cv=none; b=odBiVmBdPYgploQWG8bMc3Jxa3Y/wfW177uNE8KUWwdwETM/h3a/WocDWffiXA2kn/JWlqJScyZXDeviHZeU74xC14NFQCOyTaNEAHIrMjPvNWxREfiK0t+Fkz7ajhPkvxippDHr9sXo6jWf6W4aHSs4yJnH3Km4TE5/NlEz/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905456; c=relaxed/simple;
	bh=IQx3n36lT0J9s0y5N7HUjwaEKyy7Mlxg2gsI4no63Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr1I1VNN0Y/0vk883TjCIcckYrM1cpyjaUeBwXXXXLUg2dxa1ORb0J/r9xO5jlY52rhz6B+rUvsh3KY4aa2wyTbYyC86bhbXgCm40kGn1rMqRYhcr69YsuG38rjfGAh4wGKbtqD7YP++EczVrPo5lRGcGH5XySdYubMnDwlW85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=onJwjuNe; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="onJwjuNe"
Received: (wp-smtpd smtp.wp.pl 35612 invoked from network); 24 Jul 2026 17:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1784905445; bh=0XvJsW1Ont2cluGeW6F50Ej8GaxjA6JVCJYbQisOd1U=;
          h=From:To:Cc:Subject;
          b=onJwjuNeDQIEWrNl7rzMVekE9oAL6IXhTevWGYOOyem8/i1QHQu6pKl6G3yC9zwE7
           kkZj0dYX691cd3g6LQsvoeI7k6gEIet4ykr0R6DoKPS3MR/watNidTenziIZHin2Go
           rXTss7J15Zhzma4rhaXOQ2zAfHtKyRqz56oTSNjWDYTR3QS4a2v7z+PTgezV8DDMc9
           1wyPkaorZamr+nLBZWgdRBlSLw5MC4e7yO8EcoeocL/1rlfvx1o3xDldlrlo/XRAhn
           vNaRLKSpsaHEG/e2YL+cObb9EhgmbDd4jt+xSGmlHQZqla7ZrakHZkamti75rT3O81
           fWen164XVYKhw==
Received: from 77-236-11-167.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.11.167])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 24 Jul 2026 17:04:05 +0200
Date: Fri, 24 Jul 2026 17:04:03 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ax88796: initialize all fields of
 eeprom_93cx6 struct
Message-ID: <20260724150403.GA56515@wp.pl>
References: <20260724083411.8562-1-stf_xl@wp.pl>
 <5df6efd5-ebc2-4049-9501-e013bf68c51a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df6efd5-ebc2-4049-9501-e013bf68c51a@lunn.ch>
X-WP-MailID: 165eea24b07df514c6f227e01b6abfde
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [caLh]                               

On Fri, Jul 24, 2026 at 02:57:33PM +0200, Andrew Lunn wrote:
> On Fri, Jul 24, 2026 at 10:34:11AM +0200, stf_xl@wp.pl wrote:
> > From: Stanislaw Gruszka <stf_xl@wp.pl>
> > 
> > Commit 7738a7ab9d12 ("misc: eeprom: eeprom_93cx6: Add quirk for extra
> > read clock cycle") added extra 'quirk' field to struct eeprom_93cx6,
> > which change how the data is read.
> > 
> > Some existing users of eeprom_93cx6, including ax88796 driver, allocate
> > the structure on the stack without initialization of all the fields.
> > As a result, the added quirk field has undefined value, what can
> > randomly cause reading wrong data from the EEPROM.
> > 
> > Fix by using designated initialization.
> 
> The problem with this solution is that the next time another member is
> added, it breaks again.

I did not initialized 'quirks' explicitly in the patch.

> struct eeprom_93cx6 eeprom = {0};
> 
> Will initialise all fields to 0, and then you can use the existing
> code to set those fields as needed.

This form:
		struct eeprom_93cx6 eeprom = {
			.data = ei_local,
			.register_read = ax_eeprom_register_read,
			.register_write = ax_eeprom_register_write,
			.width = PCI_EEPROM_WIDTH_93C56,
		};

will also initialize _all_ remaining fields to zero.

I believe it is guaranteed by C standard.

Regards
Stanislaw
