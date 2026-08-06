Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA837C908;
	Thu,  6 Aug 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032913; cv=none; b=icj8n1J3UTs7O8+7Ov66k8qb4EzSMfx+dZaHKa+G/vWtYNswx89MAfpsF2caWdRTz4Oml9E3pEZ8Umurs+518Uo/xgry9anF5jC1Jv2Gxsk8ROzlZ55KUO0yva0cIVueBfMRgZrQt7oUy8NoKwhYva5z4wQNe/tScDsr2PhI1OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032913; c=relaxed/simple;
	bh=5/Kz0lXlI55PsxQqgyMPE074ovc0UCsaSgqQYpJ6UM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIanKlrTZ09v02fr+GeUrGUXZ3QrqcPA3n2QrqxTQUtfSZ38AcMKL66yVrsfWsCoovSWFVfwAGpTV/g77oDJ0CUqrxzlmVnO8oXbGtlfoS2quZwAh7s+3QO9UxyP+DSpgt0RpYtYtyb/JAX1qN7pVhCjNrmtia6L7t0ePiSAxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5u4NrsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5u4NrsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1631F000E9;
	Thu,  6 Aug 2026 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032912;
	bh=VtgUICnmqeMRlwX2nls0me3NUUN5VnFlflDQ59kSf8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J5u4NrsQaQ0QVJZnfQ03ppDSnyR8eoWuvF6fk8OtQj0zyrBZQutzCDlFmhA8YXrmu
	 ha6ToQzOIhP2KPXGhHGna7Eo7NOBtTOScYc/ZXPTFevlTfPxEGOifxl1Ci/qs4FVr3
	 b7PiiA+flLouiQDAumb/HAy4uwz4dI1sREhDJzrxG7S+wqu4QjOHYnNR0q6s3BK8Yo
	 5AxCnwGjDcNk/I/JrH2kNDCMwbRqA8HyIhfsfI2B+gUUkPf4KVZEi9Uzr1s2jtH3rT
	 2WyCBB2UCwyGFdOIUpqx2y0TpiLIPqkNKpLNRiKDkO7NwThOfn4hVODFkITq4UjkPf
	 CJ/5ghqR6cJYw==
Date: Thu, 6 Aug 2026 09:15:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 00/10] rxrpc: Fix CHALLENGE packet handling
Message-ID: <20260806091511.46a2fabb@kernel.org>
In-Reply-To: <20260804172639.2844491-1-dhowells@redhat.com>
References: <20260804172639.2844491-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 18:26:27 +0100 David Howells wrote:
> [!] Note that this entails a significant change in the UAPI for AF_RXRPC,
> with the CMSG types and sockopt to support the OOB queuing being removed
> and replaced with a new single CMSG type that conveys the user key ID.  I
> don't think it likely anyone is using this outside of my kafs-utils
> package.

If the remaining Sashiko issues are false-positives - should we queue
this to net-next, then?
