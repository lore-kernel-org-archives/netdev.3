Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6E2E7387;
	Wed, 22 Jul 2026 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681204; cv=none; b=CgL5jPNronzxUqy3Nnx6tVKJDOqbnQvEZuEp8jM81bRlb/prQB5+MJuOOvEdKvnlOmVfjRCGOtwrSik+C7dNCyojYqr2kaqoKBuNS8r5t8cli0JrNILPEoaEsVv5Z33gzch+zWqdWeAq4AclxS+6TsVOp6xsDeXyKkqChHUKqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681204; c=relaxed/simple;
	bh=2Is18EtYtwVs1jbSXEvasX13S7pZoiJ+bguClsADUJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUIAN7wfaodX8dyIjXUEhRf1tyzmfWCEjwAvLVSakUnTmmX+dHij4/+7D1yfgQB0GZUxjjw6r+TeZel0c0czCmHD3e377k4+czRClB27MDfkt73KuwMcu68Waqp9C4guZ+LHdU22w3SrSSVu4D3zp4pY+oZtRi7uem3bMlIwvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcxYwQIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcxYwQIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1303D1F000E9;
	Wed, 22 Jul 2026 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681203;
	bh=2Is18EtYtwVs1jbSXEvasX13S7pZoiJ+bguClsADUJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mcxYwQIspZ8TVcZ4aS1jAVHlbfeHMppudvhM3fQRjxqlzbJuK9VjhvRqKWBKCkH/4
	 9+3eOK7er+I5ApQvIQWzNieKgulbttp1YEKoi79OYyCFRdZT0ELnnFAieSAhDcE7Dl
	 dZDbMjuV31ZSQX8OOzRsyBu6neqpbOA6CcE1cRK7z7B3SBGhwAjIdOc6UX6cAUaaOI
	 9bj3/yGX6S+OpAD1s48W9OmhMhhn2leAUz8ekToOoRCdSsnjx8kPsFO+8iPqKDmsq3
	 XyjufTbrI6U9ciubSVy2NVZe643vRPytwKLs1Oq+JqTs3BJlb/tnJe3iBowZVves8h
	 FWYKLf6b3VfQg==
Date: Tue, 21 Jul 2026 17:46:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, Milena
 Olech <milena.olech@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
 Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ijae Kim
 <ae878000@gmail.com>
Subject: Re: [PATCH v3 net] idpf: disable PTM on probe failure and on remove
Message-ID: <20260721174642.7749143e@kernel.org>
In-Reply-To: <20260720143511.43408-1-mhun512@gmail.com>
References: <20260720143511.43408-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 23:35:10 +0900 Myeonghun Pak wrote:
> Subject: [PATCH v3 net] idpf: disable PTM on probe failure and on remove

Please try not to change the subject of your patches when you respin.
It breaks version tracking. Ideally you'd tag this as iwl not net.
We don't apply intel NIC patches directly.
