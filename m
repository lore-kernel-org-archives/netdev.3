Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20D3AD50F;
	Fri,  8 May 2026 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281619; cv=none; b=OswJWKO6X0ISH3XzjBu4eSKkz5Ndul1/jn256zn1d1aggo7J0Z04gMKz7wJCL9kh60xET5Q2oTInmPzu4NK9GJMDI9dnNyJ3Y+N5HdSWhpoZuh61AF+l5s2cv+q39ZzLLVo+plxLfjqdmyBECmUX64RDq5W7A3ddenwEJjDSK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281619; c=relaxed/simple;
	bh=+FrPfgyjI3rfWqKi97LhVDNfKh6TJzFdkuTyyuJOmaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZoOPVjfN6fdqJylIBNg9xG4Qzf4qpEmcUSSJkCuCZwqLDcJxjI8M2J5z7lGnYXCXbbufi/gWXdy101Bl0+v8/d+1v9+O74jlha55/vkoKAv14UkvgjzMHcKhGdMpPF4j+oPs1oa6DwWUto0thBZfBLpeEY3I0UeYVV1TER23Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8mGkuRK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8mGkuRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7A5C2BCB4;
	Fri,  8 May 2026 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281619;
	bh=+FrPfgyjI3rfWqKi97LhVDNfKh6TJzFdkuTyyuJOmaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8mGkuRKbFejhdhvPnIAb98prcE6xg0HDkoTapUjhHp+oL17dGUq3bRUOgU6rIL4g
	 hb7U0OFU7UzxeUkzEbBAGql6jZm4LPTfHWGo5S7PJxK/jNC4JBG14aEEnTE2fEnSqA
	 m5iJOmVd3LczvTRq7aGxnsSGkkMYpmBp5GYDsbaNGOabKPbx62UvG/DA8oiUbSm9wR
	 xU5DlwTfvt5t0Vj6X4HpAikSXqxMKkncYMxmn1lcQJT0bQlB1GUpN2cVPrrPoaKLwO
	 vEBi+IM2ABXhqLEqCAuPDWVtRlgvQ/MOTfHGkTMmVVmE+6A8X2Lb0P9+YARfFicyIl
	 Oy9qPqJogVgzA==
Date: Fri, 8 May 2026 16:06:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <sukhdeeps@marvell.com>
Cc: <netdev@vger.kernel.org>, <irusskikh@marvell.com>,
 <epomozov@marvell.com>, <richardcochran@gmail.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/9] net: atlantic: add PTP support for
 AQC113 (Antigua)
Message-ID: <20260508160656.2a318b34@kernel.org>
In-Reply-To: <20260508120156.3060-1-sukhdeeps@marvell.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
	<20260508120156.3060-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 17:31:47 +0530 sukhdeeps@marvell.com wrote:
> From: Sukhdeep Singh <sukhdeeps@marvell.com>

I have a process question. Who is maintaining this driver?
MAINTAINERS list Igor but he didn't sign off any of the patches.
Occasionally we get patches for this driver from users and other
developers and none of you Marvell people respond. 
Please have a read of:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
and tell me - who is serving as the maintainer of atlantic?
