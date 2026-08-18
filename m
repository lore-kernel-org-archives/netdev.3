Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456530DD10;
	Tue, 18 Aug 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064555; cv=none; b=AfjrLLmhBZsUgAZB82e3zOdhyi8rQDt94LQlgjzxXPzduJ/0KDCkLH0e5f7RKJoFqaoaXgIad+XCr59sJp5Yw4cHzzmgS3nXXxILkv2k4uYJeIY7+aMRssMh1d+/TavBbTN/e5Zd94LopD6opS+J33G5gcqrYIRWVmpMiWNYN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064555; c=relaxed/simple;
	bh=5aY6UpoBk8VM5oaFfLdOx+Ojw4EnmZ97V1feR6xwGqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AH5FVqXkAI0bGmsCOJ2YZDejWx3gLVhWPadJqhjlQeNPqRM9QngP4inZk2DY31/kdYFWS/x4w7KWbPyeFpwf2FSp4wvYByPQJJK4XYBWAIIs7vZ5w5Oh843z4N3iXZHAMIro6PIP39j2yhQWGMCxIkKqWEW/4IDkfTl7Q36vV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5YqKLAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5YqKLAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAB21F000E9;
	Tue, 18 Aug 2026 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787064551;
	bh=dq4wtiQE8mVu3Qee0F+uTqGmSuj2HrO11WP1YxtGqHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A5YqKLAJX773k3OlbUQhwfbj5In8TKIanlRA13bab16GlLbXFHwdRA4R1O8fCbZNd
	 zwQd4vzHSCNaciVGJayqL8b+pNiD/DxnTbK0wQ/Buo113atBesSbwTdbwiCcqxecLb
	 IFnq117+gm2Ko1C2bi1xxPelwpWj/D113IsTqUVGpWweHZql5waVfhNOCGNbaHw5ER
	 C9hY1KLpaWZ89Ts3wlrqxJObccF21MMGolgRSW4+Jl4s3WXrBH8ilts8zdeHCgJU/7
	 Ky/Gp3elUD0AEiq8ADstNESQozQtY2elyrFGf3+PleDmM3L26pruwrRxay2Ft9wBER
	 EEJrfwlKQuobQ==
Date: Tue, 18 Aug 2026 07:49:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 00/11] rxrpc: Fix CHALLENGE packet handling
Message-ID: <20260818074910.5618ecb9@kernel.org>
In-Reply-To: <2038699.1787058233@warthog.procyon.org.uk>
References: <20260817185802.0aa4c9ee@kernel.org>
	<20260812110129.979970-1-dhowells@redhat.com>
	<2038699.1787058233@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2026 14:03:53 +0100 David Howells wrote:
> Okay, there are only a couple of things that might merit producing a v8:
>=20
>  (1) There's a missing key_put() in afs_open_socket()'s error path.
>=20
>  (2) I should probably require READ permission on the key holding the app=
data
>      provided by usespace through RXRPC_RESPONSE_APPDATA rather than SEAR=
CH
>      permission to prevent this being used to pull the data out of keys t=
hat
>      can't otherwise read directly with keyctl().

Let's do a full v8 if you don't mind.
I gotta wrap things up for the -next PR and still ~260 patches=20
in the queue =F0=9F=98=A3=EF=B8=8F
