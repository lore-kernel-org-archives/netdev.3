Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33613329E7E
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280973; cv=none; b=HIWi1uj10vPzINKlTaz3YxBvj98Q7EfoVzueHK7gijWHp9AZXlmCrAsM6XRlsG6JN4R98TPB7hzRf/tLHtp7zb8wvoxoPHz62TmHjaeH6t/+lNC+IkswY4o1pB6UyEvFrjDIBdPR9Z/qgOYw7CrF3v8lqz3Upqwf0lVQ3nIcXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280973; c=relaxed/simple;
	bh=CdVr/qWTbLlByFayrb18CVfXWB/fickdGmDt2c0sBeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECfVUCrgg5hzeGYjlmaJsSe0gRnZJONGDXve6vQUzxvXTrvg+l/Tum7ambfiW+FVxwZl1YgUx1M5xZP6C5yCSRe64DpsL0GuOWYKRXwnMtcl7d+nnyLreNNb17MSDOeArnYujea4PauzlyunjngmRtbN4+3jxP5k+Gm59cqn4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3tLHT0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3tLHT0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77901F000E9;
	Tue, 28 Jul 2026 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785280971;
	bh=CdVr/qWTbLlByFayrb18CVfXWB/fickdGmDt2c0sBeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I3tLHT0H4SONYKTB8NDStSTTa/jr/O9c8cucxmzDCJyF6fa4pPsxj/5DrbFz22vhs
	 84T55nqO7uAnkZcKHFaRV/RRwLRpCRC5+1jVuZRznxYQMaERJOt6RtUkLDZi6aZ1B3
	 p+qcMfSDZPKFPP8xFrYvwRM7yaJJfwBO9NEYqQIG27zn21wPtcU+OKeqiWflDz8obd
	 NtEZMT5rpqIfkUHYp5adJYfMflkagjaN92YIhnIAPb92BCTjXApGq7LZYvQp3esbjb
	 SqcGQDDVujsv3gS+SITyVOLKDTyln8ERy2BT3J3eQYrX+ew/vjL82O0y65o8fUWMQm
	 nTq87ymPS5WOg==
Date: Tue, 28 Jul 2026 16:22:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [TEST] google runner needs nested cases
Message-ID: <20260728162251.24efb0ce@kernel.org>
In-Reply-To: <CADWJPTuet6HTd7V104+MmgaS0EO=ZcLu=FiZs_c_CtX231w1cQ@mail.gmail.com>
References: <20260721063829.7d9e6c7f@kernel.org>
	<CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
	<20260723103607.55debff2@kernel.org>
	<CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
	<20260728151333.2d778f4f@kernel.org>
	<CADWJPTuet6HTd7V104+MmgaS0EO=ZcLu=FiZs_c_CtX231w1cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 15:38:56 -0700 Sheena Mohan wrote:
> On Tue, Jul 28, 2026 at 3:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 28 Jul 2026 10:07:15 -0700 Sheena Mohan wrote: =20
> > > The recent updates have been merged, and the tests should now report
> > > sub-case results.
> > > Please let us know if any further improvements are needed. =20
> >
> > Looks good, thanks!
> >
> > I'm still waiting on the device node, but I assume we're stacking that
> > separately. =20
> Yes, we are tracking that separately. I will share an update on
> devlink support once the patches are submitted for upstream review.

To be clear -- it's not required to be real devlink.
The format has to be like devlink (JSON keys).
For QEMU virtio for example we have a two liner
bash script in NIPA:

qver=3D$(qemu-system-x86_64 --version | head -1)

echo '{"driver":"virtio_net","versions":{"fixed":{},"stored":{},"running":{=
"fw":"'"$qver"'"}}}'

https://github.com/linux-netdev/nipa/blob/main/contest/scripts/vm-virtio-de=
v-info.sh

Of course real devlink reporting is better because
it may also help users correlate problems in production.
