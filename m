Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91786311977;
	Sun, 23 Aug 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787498849; cv=none; b=MOr0B58c88qMtV4x8MKhz91KtmOdymMPagmjh/qMonpJwbgluaX4BTdWKSOy73cu0HZ3tgY9VfF7O/wPdJJyuA2dSJ7Lc9eaiKpiEmlnV5DuLekoie572dvfctKrwTN0HjqNdSwKYxQ1X1eYo0FrR8k7vE5Vsv+4yAgrLEfD0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787498849; c=relaxed/simple;
	bh=VtCLcBRXqs5W0i7OmKSw7M0mKpuRTRZF1J5L3L4mtEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA+0zS6CWv4OTeMyRDMDTg6PNnAX6jLvTfwQNjqVW8FjrfrkyK1CgsYrFKpB4Fc4qaTV+8ZNhaXCoHsXqcRPHMRRwK3rhwXLWcPE6Ch9kFkPKw37YAfIXvfKXSBhvMBMSlCLyRTLDulfErzvg190q2gaafv6wTNeAcBs5YYrjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gxsSMHjj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gxsSMHjj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2uB5oWy1ONcqvlekXO9ezfF5EXmoITaqi9ip6WVjPLc=; b=gxsSMHjjgVUOLKZXB4tclTO77t
	hwj6VzrAKAI8vUXvhVx4UkN5VocL4hqY1QXhvWoL5hr3RYMVLcU519nRexosjAHDkvfH30Y22iHvQ
	9KbCVwEndqyIppp6DKjD8only3L0Qit4eF37n4GlJSJTTYrOexo18PnrjPkfTYNRtwYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyA6S-0018Z1-Ld; Sun, 23 Aug 2026 17:27:20 +0200
Date: Sun, 23 Aug 2026 17:27:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: springbreeze <springbreeze@stu.pku.edu.cn>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>
Subject: Re: [PATCH] rust: net: phy: fix off-by-one bit positions in device
 status accessors
Message-ID: <f4e5000a-8468-4172-b454-ac97f9ce759e@lunn.ch>
References: <20260823103644.342849-1-springbreeze@stu.pku.edu.cn>
 <CANiq72mUbkEcvffQV-mNLfCxGkgTqwq1qQLuWpENsUCCBAHOqw@mail.gmail.com>
 <AOUA5wCUK5sso-ea1NbU-4rk.2.1787484007018.Hmail.2401213299@stu.pku.edu.cn>
 <CANiq72mQ8bfEw-NM4phjgp-QxEP5RpqNTkXrjjGqkX+VukqkaQ@mail.gmail.com>
 <AHMAhwDwKw6suFf01VEIOqo9.2.1787486213219.Hmail.2401213299@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AHMAhwDwKw6suFf01VEIOqo9.2.1787486213219.Hmail.2401213299@stu.pku.edu.cn>

On Sun, Aug 23, 2026 at 07:56:53PM +0800, springbreeze wrote:
> Thanks, that makes sense. I will keep v2 to the minimal bit-number fix (with
> Cc: stable) and send the switch to the bindgen-generated accessors as a
> separate follow-up patch once the fix lands.

Did you look at the history. Was this always wrong? Or was a new bit
added at some point, moving them by one?

If it was always wrong, updating the hard coding is not so bad. But if
a new bit has been added, using bindgen would be a better fix, since
it will always be correct.

   Andrew
