Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74C3672AF
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231844; cv=none; b=urttlP9nvcMlfQkn9Fpixqz0rKwJMqxAGwsGxI1xHI0QX1a//llvGalsE/I0XLeEUmbqy7iuJrAer8nIzbYEyzXFIPNBPRy0GiInySap1c886/fJFt8agfXoitKj46B3bcN9Z7DuIpHElVV1js4FbKBsFlCsLfJWQlwwqemLT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231844; c=relaxed/simple;
	bh=1R45gjGw3yk4QDFnPhnTQM3rZfmFUCzzawTkU4gApEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyZd2FKL0u+IP3jOxVf73myk2LTDOhMW6vP/qnDd9cmIKoS31R6U9McKmG/PCg4Ak4sMReSIQXkUmUEl6/xSxvPGBVAAydYxypaZOLV5qlG1geIAEGQ0FbvfQOqfhtpQRIpDFWkHyoFAIxODvZQ9CpBb3PZGtZfeOqnNbk+dh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VjeRMA5q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VjeRMA5q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V17nIziQpedijr5jFKsSOwjmDg5NXAJjUA3919oyCpA=; b=VjeRMA5qHMRJGICrfRQwdoKDlK
	I7W4h8VfojoZXEAebKFWVQKnTglM2KgXfJnlweUfkdKPvOow2o6AWZSCKs01QfeFMWGvj7dBxq4t6
	eYcJ/yq7+9FEXXTVGNC4Ttoxeq/AgKDHQDqatF6GZG4IHMWrCNIFAGq5/nNLq8+dsUNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDpE1-00978j-RQ; Mon, 05 Oct 2026 22:23:53 +0200
Date: Mon, 5 Oct 2026 22:23:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jhs@mojatatu.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	pabeni@redhat.com, vega@nebusec.ai, bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com
Subject: Re: [PATCH net v4 0/1] net: loopback: reject skbs with a short
 linear Ethernet header
Message-ID: <b061d645-5969-4747-ba29-72bcd552a674@lunn.ch>
References: <20261005052249.1914367-1-weir@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005052249.1914367-1-weir@nebusec.ai>

> The earlier discussion established that restricting an individual tc
> action does not protect the driver from packets arriving through
> other paths.

Please enumerate these other paths.

loopback is heavily used, and needs to be as fast as possible. We
should try to keep very unlikely to be true checks out of it.

> The following reproducer provides an additional IFE-based
> reproduction of the loopback failure.

Can you fix this particular vector? At the point you decapsulate the
frame, you expect to have a valid frame, so you can do a length check
in the decapsulate the drop the frame there.

    Andrew
