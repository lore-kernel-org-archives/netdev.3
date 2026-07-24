Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B23FD96E;
	Fri, 24 Jul 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897864; cv=none; b=ShwjcvZvnL2q1dhqcjJ8C2RhPK3Va1o/zQNvzEyq/4lURo52ZXqWljJAxHm2kQkyogw9NQRIsrHy9S9ZiUFDZb7iTHRv8F/O3v436wfnzeaS2sdhNckmFQ7xLGpiQ/cCceQY17xHL8csOqK9nhaJVyYTL7WDo41liG23wbUuxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897864; c=relaxed/simple;
	bh=cbANTFT4KQ8G/bHErSXF4vEz1KY4tVQ9ybechz10XEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lryo1Ajo4CWbcry47Su7IDjowiKnKA88rUKbbT74FmxHACpo/2QQ5OzAxwRYy+iaT5bKU25JMokgI4d44ajHRFW0/9W7c64tqgh9IQWdAi2mm70Gt5U5Vv9iroxB06MT5dVdkMlNW+PDv+zYAAcrTzckkFnRrusevSDXvYDzyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3JvtKtEA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3JvtKtEA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/hoSMGxPGz3NtXAkO8ECf95AmD24vGd5ie1jJy+1XR8=; b=3JvtKtEA71e1VoLwyg7gc0/vN9
	vddWtVzDBlgeeekby+Px3dkVOosR/Yu1ZpH06c9a5nQhLf/v7Mf1gzqqlriTz/rYGWwz4SAhCR0KQ
	TNqv7y0INirf53bMzcWq/IVawWQaU6kokTFFtslcywlGsKHdzEMij/ApJyi+vP84REJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnFT3-00DzTc-Ay; Fri, 24 Jul 2026 14:57:33 +0200
Date: Fri, 24 Jul 2026 14:57:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: stf_xl@wp.pl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ax88796: initialize all fields of
 eeprom_93cx6 struct
Message-ID: <5df6efd5-ebc2-4049-9501-e013bf68c51a@lunn.ch>
References: <20260724083411.8562-1-stf_xl@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724083411.8562-1-stf_xl@wp.pl>

On Fri, Jul 24, 2026 at 10:34:11AM +0200, stf_xl@wp.pl wrote:
> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> Commit 7738a7ab9d12 ("misc: eeprom: eeprom_93cx6: Add quirk for extra
> read clock cycle") added extra 'quirk' field to struct eeprom_93cx6,
> which change how the data is read.
> 
> Some existing users of eeprom_93cx6, including ax88796 driver, allocate
> the structure on the stack without initialization of all the fields.
> As a result, the added quirk field has undefined value, what can
> randomly cause reading wrong data from the EEPROM.
> 
> Fix by using designated initialization.

The problem with this solution is that the next time another member is
added, it breaks again.

struct eeprom_93cx6 eeprom = {0};

Will initialise all fields to 0, and then you can use the existing
code to set those fields as needed.

    Andrew

---
pw-bot: cr
