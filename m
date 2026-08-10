Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D74374195;
	Mon, 10 Aug 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347660; cv=none; b=qk/rg+Wo+jPppFwoVrTFbdIwng5uRqsZHo5reJDJ/UffPHBG10/2NUOf5e44hnCOpy0cR+opgI/pEYh5fUCAFiJbNOjTtQyU2TvoRlB+8kDds32MPugC8Rd7FOFmTa1yd6c7EpIdLahGsCFz2vpdSPwGhYslVUqwEsOZR+NvPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347660; c=relaxed/simple;
	bh=s/ejsqjzJtucVCk5tIPyOezjgAYnSKBqvRDEX5FiO9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWbB09+OaA7dSikbnRd51cn0V8wohbeXpK7yUYKlFjJHqMmMoFBQpkXX/DlE85LD77Fmc4Var/UfIlPuL0PlTpdu5GPeX59wMt/5xvg3TZeQFXgAqXGMosHRBditgSlJ60Wh4aagAmDt9N3NrymLjjm69RbGl3gmF5UtIC5xe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH8lgSnZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH8lgSnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9941F000E9;
	Mon, 10 Aug 2026 07:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786347658;
	bh=s/ejsqjzJtucVCk5tIPyOezjgAYnSKBqvRDEX5FiO9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PH8lgSnZiWqJ7K0sM+ywe1O1qj88DZe+hxy8OvNoooPdUIDwCIt8m1uufYsajM4cu
	 yN3eeHF4EKkhJyDWZ0gwtC/eiWPF/LQp62SE+k6CJU+BD8lOAg50cx61OyzhGOm+TX
	 lh5sHMzGkLCj98a0Q9NBBrSlFTS5MFzYxu7a6hyhRzASF9MnNT8ML1lZKT55+vAMwf
	 c5nTvqROOnkqxUVa/5ocnSR2JW134cRRoPX+otTCXy8oMwgJ+Ya1wWc47K5D+5cZ/e
	 LEZzCotL0R290dKEWjbxXd5TUWJ+1B6Gsy62CliRS1jW+qdyB/nRpIHpuuOvDQIlqG
	 OWEtk62byx3Yw==
Date: Mon, 10 Aug 2026 09:40:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Message-ID: <20260810-proficient-therapeutic-mole-fedf64@quoll>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-1-532d4a143805@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260806-wiznet-link-gpio-v3-1-532d4a143805@marmottus.net>

On Thu, Aug 06, 2026 at 05:00:00PM +0200, Arthur Cr=C3=A9pin Leblond wrote:
> Convert the Wiznet w5x00 SPI Ethernet controller binding from
> plain text to DT schema.
>=20
> Signed-off-by: Arthur Cr=C3=A9pin Leblond <arthur@marmottus.net>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

