Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD21BC08F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499512; cv=none; b=OGnlhGRKwy3UJt2GOOTEMzfIngz0QrjUZwESK8RuYs2lEUXl8QvPk0X7Np/e0N3uJ2wiw69TLX+6SkIs0zKCvEzRfauqfez6lS44Snei0+URVev0ZaQfoiF/sbR7kx4sxq+TWXpgLzYW49NOSIXrsPmDC2FKtGRXA7ymPZuol7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499512; c=relaxed/simple;
	bh=nyG2GoCkIao+gBsQLbXrOzS9ALvgdZ7FvGSvoSDIoKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3oCBVEH7uMLtKlZ9kxx18rjE9CD+cwXiLVwzMSgo0ZHcDyHv7ihMizw9tP3Yd3V4lQbFmWGaU1POUrDCzSt5JeEGyPv0o8vk5XJazYLwhQcdh4ZkABIrWsD19u2ViA3/XhKQcmmQu9oF77tCyc74bIcb+mC9y91kbloL1ZsnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMQDwTKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMQDwTKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E37C19423;
	Tue,  3 Mar 2026 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772499511;
	bh=nyG2GoCkIao+gBsQLbXrOzS9ALvgdZ7FvGSvoSDIoKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IMQDwTKRsDADYqaHfwObluvARltVA7Nii2ONL6CnFtWH5HbK/GLv8opOtLoBnFM8m
	 6gK4WLDwTKn5LV2GOBcZM/zexkgypDPZD3FEAjBI0ki08Cbpcc59xllLywBZY3IEO5
	 gyobTMNF6Sw3bnNQmHdZUYon2yFdlHqdqKXom1MSFl0EmQMOsVVGpv4/wCkOMlNXOg
	 Ahqc6AG9p/5wGk9gIxLiWp4v1cCFIfNachpBua80HuaQgOvnW1VTH1CMrFBvWjDtea
	 JkEW5KU62/HbUQi20uPvWXGGZ3T4YP6dKcnt4gBIkR2aYREwXs/1y7Ij4uDUX/hZAV
	 8/g3flKFincOQ==
Date: Mon, 2 Mar 2026 16:58:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org
Subject: Re: [PATCH net v3] net: openvswitch: clean up some kernel-doc
 warnings
Message-ID: <20260302165830.473bb135@kernel.org>
In-Reply-To: <20260301011714.3070073-1-rdunlap@infradead.org>
References: <20260301011714.3070073-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 17:17:14 -0800 Randy Dunlap wrote:
> Subject: [PATCH net v3] net: openvswitch: clean up some kernel-doc warnings

FWIW when you repost pls use "PATCH net-next v4", we use "PATCH net" 
as a designation for patches which need to reach Linus in the current
release cycle.
