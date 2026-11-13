Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591552;
	b=u+++lhRWvZVDNMQAr4EAB0BBmiRoFbBtsHBRlNEHrVpGkhe6QYj7BjI5czQo/X8dzdil
	 KTXUioM4TmMPNlXc8aTa2npl4b4tuagDck56WC648rHCWZ+m533vSJ4V7fUw9ctmMvWLP
	 gwjl8IhyeUNGJZosAv9PHmd4hKacEl7ur4SuQMP6d13bNNo/Uaz/s9kKFt1xmA/RvpXyh
	 rGQLWH6YNnYnA96S44e/1bCYnZ0gaeNCw5AzggTLvnKmkUulgw594QsgIxYgOvefAT4wS
	 F19OBL2j99kR1gZYCEFzj33DChEFL8aKnRRljNJzWK2DRDfPWAZdBH0feRbZuMTp7aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591552;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uXjsczIRPfdFLyUe9gFxsbcphrYr/OMPosC5b12uIpk=;
	b=kJpOF43nUAG53RaKPUdHMUdEeRe1i3lMR3L9zwIuJRjfXEKo4IGE7am+VUFznsk3UFVU
	 vm0nFrFHf2gnfevQUdMceHb924BlfPcGDf4gnU0fGQrDLBvQvGLQ7lVHG94+IF+jKBMCh
	 0HNtXERX5JIKXgLeVGlMaYzVssX1VaNBvFXXDk+0d37qbr/RvcxFqv9bl6x3vo4dGpRH8
	 D975QJWjIHJ+A994zNcIBRJGFpGh4BUwnjF9KdCQ0e+8hDataOT4HMycz/NeHK+aiYT3W
	 kgyHvxpVY32hdbEFGjklyIXCbJZPJe8ybW/V41XhFFlCoV0UNrupWECsPsu8a0HzWFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhkbpxAX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A9606D4BF;
	Fri, 13 Nov 2026 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhkbpxAX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF95D1F000C4;
	Fri, 13 Nov 2026 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591551;
	bh=uXjsczIRPfdFLyUe9gFxsbcphrYr/OMPosC5b12uIpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NhkbpxAXIsU22Qqe4IRzCCwShOM6JW63fMuUXhimI0SWOy7SmDCuxwcbE0Yq3tHso
	 8RgVjwZznBJP7OZtysSMUBhklzrsL1uQYO20d4X191PBmIlDAz/sI8jEXPu0bVwXuN
	 5W09nitHEmVrx9wI/NzrilqsV2ARiIz4njSefHnPbv8etEQ/qHDxubOab/RIIN/mZZ
	 XmC9Xcv0tqZFZCmdhCUfXdd74OVlsJubGxRD/i33vJ+oV4yaWm93l4qYIrBuuOS+W8
	 23xre2XdmxxkJFurQHeCVUi9J/sJoneBl77I3EHDli/V0R9+Par7dfko5xC5WpiYHN
	 hHPeInNoRmzDg==
Date: Fri, 13 Nov 2026 17:39:07 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sdf.kernel@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH RESEND v2 1/2] nfc: llcp: widen getsockopt value locals
 to u32
Message-ID: <20261113173907.GY18859@horms.kernel.org>
References: <20261109-getsockopt_phase3-v2-0-d0f74c6e0f37@debian.org>
 <20261109-getsockopt_phase3-v2-1-d0f74c6e0f37@debian.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-getsockopt_phase3-v2-1-d0f74c6e0f37@debian.org>

On Mon, Nov 09, 2026 at 05:50:37AM -0800, Breno Leitao wrote:
> nfc_llcp_getsockopt() returns each option as a u32 (written through a
> (u32 __user *) cast), but the temporary variables are smaller than that,
> and they are promoted at write side, example:
> 
>   u8 rw;
>   put_user(rw, (u32 __user *) optval)
> 
> That is fine, but I want to widen the rw/miux/remote_miu locals from
> u8/u16 to u32 so the following getsockopt_iter conversion can pass their
> address to copy_to_iter(), which expects an object of the exact width.
> 
> No functional change.
> 
> PS: I am sending this as a separated patch to make sure this conversion
> explicitly reviewable.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

