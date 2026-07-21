Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83B3E92BB;
	Tue, 21 Jul 2026 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593172; cv=none; b=FLwJIiVdfQ6N5jSx2+UOvzAc4x/SdmUH9oEcgGA1+0s6BSKyAHbZJ+7pGdX+MmKvcB9H3eHmxI1tIkTjjrG4p80r8zxmvdY/fZXEbYSVmVVCCk7htY8+gHITLeVB/nZLexpolzuOfiztyN7nhVRqFt7Kb+soOWqbRIrb4sj0S7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593172; c=relaxed/simple;
	bh=6xgbS8WFV+dZ/dRH7aensWqVf2r2RGXJ1NLN9e5kgQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIsLCaqxS6Ey0kSddXL7BVGB93l2yGurk401DQmJONd/Zsnso5b0Y+EKcL9bpw9Nzko4N3rYgmofazK0O7D3mulAf2dtZU1HTgl8pYfIBCmz7MJYKyZoDbW6KjOIZAq4scMqVAKoNJQ5Oq0XxZiFwRkqS4WRbon3DpgQv0eKbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9QmZ5rt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9QmZ5rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B9E1F000E9;
	Tue, 21 Jul 2026 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593171;
	bh=iugQmqjGxPsm8PSat81QnnkIwsvpLy/fAqIgpuUPC0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G9QmZ5rtw7iQUVBVFqwi7x0TBFxagtip3JfavtOMrHcf3MWxFkI66+X60SBiWRN/d
	 dxkQgIqkzQv3q5e7olY9RkAI5B8EbBhvC6psgByhoUGHl9z3SGPflBr5PoDc+Q5Ll0
	 b9BS5NeGN8WPTrhREdiYw2n1jw1YxxgvoN6f99uZKosDuCzOY4C3+a9+8Hbq+Mkhwm
	 5oKvd7Eq49iMVBvNnlc8q66G18kDNjqkxJvVD59J9x5CgHgEzmiGrdj8vhDLOM3DfF
	 dQ+wjMQwLjI0E561KvZ+FzqaaiJ3S/jK5+3IEzO/gD5Ft7aiSkuhUAwp6cdmLKjrGy
	 EiCV3dLAFsXoQ==
Date: Mon, 20 Jul 2026 17:19:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: alacritech: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260720171929.4ff8decf@kernel.org>
In-Reply-To: <20260704152053.49780-1-pengpeng@iscas.ac.cn>
References: <20260704152053.49780-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jul 2026 23:20:53 +0800 Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.

ditto
