Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155B3BA25E
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181330; cv=none; b=iHA7L5+CnvFyvFtJ0FiTwGPKWOhEOvM9QlJ6ZHe8ixBcwidmIfC+8L6L6dtcu96SCdhuXRbjgN/8vgGZBRT8+M8/CeOjthkqLvucgSpG4gq/D2xYdlsZfkT3t5tM/hLDfXid0XtHdRCRsLqT3llmoBScygiIXGloRCP98qm0GlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181330; c=relaxed/simple;
	bh=XUZGkG6NcUKSpmL3skQqQZZtcxMF/YmZw1d/4452TwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BE7BVYh8u6Ei7wEcgTgNw0vNMMI0kx3IPcJll9wcSSRCQhWnIYjCIZ3c8a05M+QeaTciX7L42z+SpR3F0Pym14cHE8zCes/dfMCIYbPfeN6DxF9q3XGeFqnE5695+xPaBVvmnbr6F6+16vAyrIeGAHvDldu/7GIzK2TULKi/qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md17tXlz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md17tXlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41B71F000C5
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181328;
	bh=XUZGkG6NcUKSpmL3skQqQZZtcxMF/YmZw1d/4452TwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=md17tXlzW/uRteXNDIdMFITdQfI+e12Ozf4x16h54vmwLPP2N2NFuxvAFz9qyPgQb
	 e+b+55StGdHmROJbODpMR6TJrdDzlXM1qWA3o0IjuTOBrvYoNzb9Htb0igs6Fw6gvB
	 SPOE19Fa0fAr+xaUyvx8c2O0tDGoeo4+EXjsAsb4QDAQOAdRWyxNDqY10+j87NV9VG
	 mzuZpFOYR0vgxENhh1wy6WCECYsmtrqGoP/+gMUgb4UmqiorIWMOhMwYtoR9hhV3cw
	 w3mNxz6UWtmn8kg+0BQNticspaCq/48RQtC8qxffBBX7GZ1DmuxWTpRcIScWbCia0j
	 4e9k1igCjnFXQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso302929e87.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:08:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxSzY9dP7NHDKFb8nMEtxUrhkyDlXQeQkQ7bbHL18DqmSgPI4LUVWI+MEPrVCytHx1dVrV42T4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7gt3CS63qFmeU+YoaDbhrZezgjb8flDsxMlXtFnqKhNdnA1n6
	ZDKS7gDFfOEyCBjMMYTJzpis4ws01MJQ4XyKxKtuPGOAJjbAI/QwJ5HlpprfpHxHOCIC7OrwNqP
	ognXh5zcSGj9HFk9E3KA1t0O2oUGLqf4=
X-Received: by 2002:a05:6512:65c9:10b0:5be:50f5:9514 with SMTP id
 2adb3069b0e04-5be50f59560mr52120e87.9.1792181327687; Fri, 16 Oct 2026
 13:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <4a8fe6f9-bf6f-48b4-b4ce-d9a1d773dafe@yahoo.com>
In-Reply-To: <4a8fe6f9-bf6f-48b4-b4ce-d9a1d773dafe@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 22:08:34 +0200
X-Gmail-Original-Message-ID: <CAD++jL=q1OccsOoeDA+EuRqvngu-jUK60P3xQ-Rt_wKYz+ZO7g@mail.gmail.com>
X-Gm-Features: AclHuK-GY6A_rqsDCrnCUEbovna_932PAL0ABBL6EpyGpHuDVFvgc73ZJ19jwVc
Message-ID: <CAD++jL=q1OccsOoeDA+EuRqvngu-jUK60P3xQ-Rt_wKYz+ZO7g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 6/9] net: dsa: realtek: rtl8365mb: use raw VID
 for PVID on family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:06=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> Family D has no working VLAN member config (MC) table. Its PVID is a
> raw 12-bit VID in a per-port register at 0x0700 + port, whereas family C
> stores a 5-bit MC table index, two ports per register, at
> 0x0700 + (port >> 1).
>
> Running the family C code on family D therefore reads an MC table that
> does not exist, and writes an MC index into the VID register of port
> (port >> 1) instead of the one of the port being configured.
>
> Read the PVID straight from its register in
> rtl8365mb_vlan_port_get_pvid(), and make rtl8365mb_vlan_pvid_port_set()
> and rtl8365mb_vlan_pvid_port_clear() use direct-VID variants on family D
> that skip the MC table. They keep the family C frame filter handling and
> rollback on error.
>
> Also clear the family D PVID registers when the VLAN support is set up.
> Unlike on family C, where VLANMC index 0 is the neutral PVID, the
> register holds a raw VID, and after a reset it keeps its hardware (or
> EEPROM) default. Without clearing it an unconfigured port could report
> a stale PVID from rtl8365mb_vlan_port_get_pvid(), and
> rtl8365mb_port_vlan_filtering() would accept untagged frames into it.
>
> No functional change for family C.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Why did they remove that ... weird but it is as it is.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
