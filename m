Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941936;
	b=uvTIIN9Qi5qL+0vIpIc9q4tOgz9n98ZiOX43NrOoa58BKvKipn2/tfyrZlxbLlbSMwJk
	 E9KlNR5afwtlxyp/dnl+t7cNbOgz+Fd6E+dUztaRUgKIX7tLWYlLHR+hdiWohp56mr04o
	 6liRYnU4XZtNgQW6qNOQwgnfJMPe8h+UBC+6sSPRNrucDzoB0t5ndbYgdJoYiF1OD0B6T
	 i11VN+qY7S7jzcM4TQtkhjROn+d3+CwRZMwUW6rIPuLJZKHkPhX8+eeMwbUNMrGoT86My
	 2p/GvTv6WetHfULF9T/2GwOS9254O5KLIijs3j7K0iPE4QuKy4AEXRPTgbpxi7G4+7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941936;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GvFbRDt9N+7C69MtgtIwc3N0rSQFH9U0oZpEt2kjaxs=;
	b=ayzC6FW+Es09FThg3PsJxgTGz85HzPpOgJ7JzNlLoRJqsqW8j6goZCv2JAXBlJv0KkU9
	 uP3M0BVvC2LPcvoVqdJvyVZsmorlyOyGBho9Wf/Pkoy0sp88JEAs8mI49l21HM6tA2PDG
	 986HXqSnXnjzesiRslzHvv7PBhzYFBNai1ySUj4kCr3b5T+C+++CeAC7drpdB2YE4ziEP
	 MtdFc94rzphEulJuyARyV6EB0+7jnsv+cFgcxeW7XbzDMAQjFu+JfyrRv7ozpRp2k1AJQ
	 5vSw/Y58dgYDhK1gfE3vNfWlLx4im6RlZLWT3W6pzdU6YrH6lhX+2vkehtkXYIrjOtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monroe.io;
	spf=pass smtp.mailfrom=monroe.io;
	dkim=pass header.d=monroe.io header.i=@monroe.io header.a=rsa-sha256 header.s=protonmail2 header.b=aJmjGq3f;
	arc=none smtp.remote-ip=109.224.244.117
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FE606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 716FE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monroe.io header.i=@monroe.io header.a=rsa-sha256 header.s=protonmail2 header.b=aJmjGq3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail2; t=1792941932; x=1793201132;
	bh=GvFbRDt9N+7C69MtgtIwc3N0rSQFH9U0oZpEt2kjaxs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aJmjGq3fVqUzzvucHFVX4cozRV+2bEu1o00N0QHZm0ATVAK4G+nzWzSZCpgOMHtoj
	 7O4/VznTqproiyYtzue/3MMNm0Qw2yL1Rz/DJ0QMlz43QpZuoJIDJ1l6jcfTXep4kq
	 HFQtbjiJTJFAjcHo2nzwcnzqzG4e0Wi3IcxeVfErpMNPM/KXaqUohJWfcRI1fXI624
	 3/smfO2GbcEuI7mJcS67BQnvKFJ9FNolGvAv9qpkua6VUDQ/J6WqtU/walvflRhlIz
	 3oqEBCcpOXvCfKRXhSCrjLZKPq48n+h2CTxe5AFtURAtjJ/hDVWj/vnt0sNo/U+QUR
	 7G1I/thm6qWsA==
Date: Sun, 25 Oct 2026 15:25:28 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Chad Monroe <chad@monroe.io>
Cc: SAYANTAN NANDY <sayantann11@gmail.com>, netdev@vger.kernel.org, lorenzo@kernel.org
Subject: Re: [PATCH net v4] net: airoha: keep PPE offload when NPU refuses flow stats
Message-ID: <J3XqO9fJOEvpsUH9m_DyrV8wgQzdtZdfhE8KZHv9ejvVty51zjizvG-0nmYn8ZhTGRJnLq0OcEbX7l3DvpqFp8dFEYuWYVpV5ZRKnGXmGKc=@monroe.io>
In-Reply-To: <05adf618-f608-4c8e-a862-4c1d0779567c@lunn.ch>
References: <20261021100423.9159-1-sayantann11@gmail.com> <05adf618-f608-4c8e-a862-4c1d0779567c@lunn.ch>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: f8738730b7642b09b89bd5a4b0da7d4311766c25
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 21st, 2026 at 5:49 AM, Andrew Lunn <andrew@lunn.ch> w=
rote:

> On Wed, Oct 21, 2026 at 03:34:23PM +0530, SAYANTAN NANDY wrote:
> > From: Chad Monroe <chad@monroe.io>
> >
> > With flow stats enabled, PPE offload setup requests flow statistics
> > from the NPU. If the running NPU firmware does not support flow
> > counters, the request fails and the current setup path aborts PPE
> > offload.
>=20
> Since this never worked, it is not a regression fix.
>=20
> Why not keep it KISS and report the firmware is too old and suggest
> the firmware is updated?
>=20
> Can the driver do the firmware upgrade?
>=20
>     Andrew
>=20

Hi Andrew,

The NPU firmware bin is downloaded at each boot and is present in
linux-firmware so no issue with keeping it up to date.

The main reason for this change is to behave better when flags mismatch.
Previously, loading a driver compiled with flow stats support enabled
would silently fail to offload if the firmware didn't have support.

I did not like this blind failure so figured it would be better to
check what the firmware supports. If flow stats support is not present
in the firmware at least we can still do offloading.

The main question is whether Airoha will release variants of firmware
with flow stats support disabled in the future, or if this flag will
always remain enabled. If it's just an issue of old firmware (all new
version will support it) then report + failure is sufficient.

Thanks,

    -Chad
