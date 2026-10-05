Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42443DA5A0
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200825; cv=pass; b=WE6qOEHbIGHGvT5YkdlSb6aZXLYh1b+x67Fa6IxUDpj+r4YjNuxT4LtPU/rCYWnypdN+J5CG+HDggRrm8EdySMp580WJykmG7VP/Ao8jQX0DFg24RqR+0HTqsc46ms1O+F3/slY8LEqaUsEWhfO5jto0TxoiNPIL2ZS7Op7S0Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200825; c=relaxed/simple;
	bh=5dG4vqKbCleDNCspP7eaU8l32l2SO2D93b4w1i4Gydw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=garf8h5hrT7JM477NBvCcylj0Ax/0fDeG6D00XMmI/LiJF5d6e1A0MjtjRJiArmd/0YewG8glwjoLSZLNBK9+o/CnFZmOk9FgyIyq8rTq3AFDPKWLl/n9lQQbv1O+AW7deDelGaOfO1vFr8sWQ+rBEXXht2Yk93fu7jMJ+2WWFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+37A4PS; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+37A4PS"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b34f95a859so38575b6e.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 04:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791200822; cv=none;
        d=google.com; s=arc-20260327;
        b=OEtnozAhm+3wSHVayjzI9CgMDEMq/7KhPBsYkXr/PBRFWzEFs5/OZQae+8375UlSSE
         xQoobtFKr11Mtf3WThI2Ne/QH/hwahutDHITK+TSRSzfQdy8Ye15ayrY2xRADsFCNGx5
         5YQYewL33HW8yGzzMEWr5QnKPbNQZNB69xsCmW9hjLV2uWApuYffKFy2945kC7kU+JNP
         CSdLhtfAnDV3RgN26sm0vUfuwGEd7TVcW8n039S07fKBhcbL2RmPjbJamYhfId6yvySc
         WKiZwroh55aV/1XeWKdFKH67VtN65dET7zyGuAAHlJ5P0v4Z8in2GAbzFKXtjPowBr+B
         fySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pvCiD2TlnrBGUsr9lII6CP6TVaOsiM3kncPZ0M5Ea/c=;
        fh=OexzE3FObbypKvqVLd2H3vxqfAnJZmQ+ArG6ci+4618=;
        b=F9iPm21g664aasNxeZng0ySPQL/C31AQhbvd8oTndZ/vLfQtnXM5gp24/CjYjOJlNZ
         yjiJ4meHawTjTG87FteT1tZtN5OCUOIUphe01OC7D4YvY1r8ApU5E/H9IDC3nMe/5R/f
         pH+r3SvSXn+fvSxTomPOdztRvtrHuWi9txrb/ZScGiPa+S4a9V6ECg/ssctiH8/OMmR3
         iPx2PyZVozbXb+wPea4EnLPKdBhZWqScQXJZhjGmYpP1qUkBLkZT9/8VnQAO/g188CaO
         BDvD5dn6prXp3ChARm2UoxxhHnqjdsU/jX5QYcI2PsN6FbvrBP+KWAj3MMETEndB0XZp
         O6Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200822; x=1791805622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pvCiD2TlnrBGUsr9lII6CP6TVaOsiM3kncPZ0M5Ea/c=;
        b=A+37A4PSiqQqyql/+ptCewXtsXsVmIZdeSgKSSlB97b6llKqdhxlHQwU/SalwdN91o
         5TQideclEIuX51PWWTUjYg+ltMcOMdP580SRforOcEVnkonTDsLroHD4XOn5L3ZOdjhP
         LZpof7/w5Ew7jV4yN5K4TDo54RBT+9O5LUY2WPPnUmEvJLJ2ch4H0tQs3C9ZPXZmIgEq
         FmguQJkm1zV/+PB972T8BjDnFRC//8W/TlsQ/Xa6ZwShp0EwacW1kD5SLgDeRZSK44W7
         P80AHGXtFTF41+zQHwd4hrkpuR3nUfzqLx+UBEZ+PkyErnLqyI0YWH327d1nu3ZaiLKQ
         +FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200822; x=1791805622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvCiD2TlnrBGUsr9lII6CP6TVaOsiM3kncPZ0M5Ea/c=;
        b=qJRrDR9KnHRZ2+UKJ5aKDT7Yphdg3skBaUVyARXV3wxJ0js/CsHYmD89Lx4IvhDL4K
         QgnEzmUyoMxuCpKe+Urk8eHx18T8Az7cFJKFdEz55Dnz0n4pS6LD3P21u5jL5ubMy2Mp
         ni+VTRvnlTfRw0iash+OEhw35uixhaMZZGN4dERTmMbohd7mAnXe9Sj9d2gZGOc8D+tn
         gNWweyVrkqEXh9rjctRXyKvF4fahnr36xUdVwUAvrGB/1dT8YuUPQHGOp7OuzNHLGCUg
         SsciexBY5jLHr92ez4d1sQ6G2e9T0TJ0r0UBbS2SdZ3EWoKaWQV+CIQ5oggqf1tE95IN
         v2Nw==
X-Forwarded-Encrypted: i=1; AKwUvBwxxG8LiOKbm4+8idFD1LPa3RJUAL/a8o7ux3kE6EQ3kblue0KRtR9mRx5p+mVhevHOhrOwHsU=@vger.kernel.org
X-Gm-Message-State: AFuF++lBc+qcWnBaCU4XYXB2J5gmdzef6oVhPsucL5Okqd5ZH0ByVDVb
	x8ganC+4DLol3xcj+XJxk7POXxZeEK0HecrxiK5WiG7ascbjfvhlrlcejaU+lWJFg0rzbVRnrHq
	EzVwMSw10DVZuPNjw+w8LU07SVwJgvqA=
X-Gm-Gg: AYBFou0UPELPY9lpHRT0j/R4UxP14++QZ0ta3jSQUKhRTYMUQ6d/h1+LluzXt3geRga
	iD7d4xIberCpK0xHLcd+WGlvosRapeghN0E+NpDiB+iCEjZE4Om9kLBDtgu6fAfroDLgXGw2VYB
	UIsyWFYp2yczn2VaK0uXUjHyG7GsL1bxODu1+b/tWfsTmOGexgBrraliG1MYMU3aAbAz4nWmxvU
	5eAkMFtTVfLCOz+yoebYzVDG/7VuR7R6+E3ojJUeF8KagVbwVi5YvF5lL1VbbkHtDro9p4rJdpw
	aVHbE1k8drxLvrALE1As+Djrp6fXlBuSvQ0F3Z+HZM9V7kgmn0RX6IwqOkwTsgAL76ZXrGw=
X-Received: by 2002:a05:6808:238a:b0:4e8:9e40:a0dc with SMTP id
 5614622812f47-4f526845500mr13041029b6e.1.1791200822366; Mon, 05 Oct 2026
 04:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-netcons-fixes-v1-3-bb5ffe5e698a@gmail.com> <179084525499.434549.454029290243818186@kernel.org>
In-Reply-To: <179084525499.434549.454029290243818186@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 5 Oct 2026 12:46:50 +0100
X-Gm-Features: AclHuK_VCqFiRp23GjqsOFz6KmqlCD3ZHvlL0enmA62M0GN2prVrFjDkVN5QeTo
Message-ID: <CAGSyskVROs===6nd6Zu7KYqzuzhommRKPN321KFV6pYv9=j1sw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] netconsole: avoid printing partially updated
 target attributes
To: netdev-bot+sashiko@kernel.org
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:00=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix is incomplete for dev_name.
> - [Low] The commit 'netconsole: avoid printing partially updated target
>   attributes' fixes a user-visible race: configfs *_show() callbacks can=
=E2=80=A6
>
> --
>
> netconsole: avoid printing partially updated target attributes
>
> This patch takes dynamic_netconsole_mutex in the configfs show callbacks
> for dev_name, local_ip, remote_ip, remote_mac and the userdatum value.
> Readers are then serialized against the store callbacks and should no
> longer see partially updated values.
>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netc=
ons_ipv6-v3-7-bc0915e8c75f@gmail.com
>
> > Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-ne=
tcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
>
> [Severity: Low]
> Should this have a Fixes: tag?
>
> These show callbacks have read the fields without dynamic_netconsole_mute=
x
> for a long time. dev_name_show() and local_ip_show() date back to
> 0bcc1816188e ("[NET] netconsole: Support dynamic reconfiguration using
> configfs").
>
> The IPv6 rework (for example 56ddc8d48e75f, 46b3f9e7e761d, f6e96d72f64a8)
> made the window larger by adding the separate family field.
>
> The other two fixes in this series, "netconsole: finish enabling the
> target before releasing RTNL" and "netconsole: read np.dev under the RTNL
> in local_mac_show()", both carry Fixes: tags.
>
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 5f4311726d11..627475f16383 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -861,7 +861,14 @@ static ssize_t release_show(struct config_item *it=
em, char *buf)
> >
> >  static ssize_t dev_name_show(struct config_item *item, char *buf)
> >  {
> > -     return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> > +     struct netconsole_target *nt =3D to_target(item);
> > +     int ret;
> > +
> > +     dynamic_netconsole_mutex_lock();
> > +     ret =3D sysfs_emit(buf, "%s\n", nt->np.dev_name);
> > +     dynamic_netconsole_mutex_unlock();
>
> [Severity: High]
> Does this fully close the torn read for dev_name?
>
> dynamic_netconsole_mutex only excludes dev_name_store(). The netdev
> notifier path has two other writers of np.dev_name, and neither of them
> takes this mutex.
>
> For an enabled target, the NETDEV_CHANGENAME case rewrites the name in
> place. It holds RTNL, target_cleanup_list_lock and target_list_lock:
>
> drivers/net/netconsole.c:netconsole_netdev_event() {
>     ...
>                 if (nt->np.dev =3D=3D dev) {
>                         switch (event) {
>                         case NETDEV_CHANGENAME:
>                                 strscpy(nt->np.dev_name, dev->name, IFNAM=
SIZ);
>                                 break;
>     ...
> }
>
> For MAC-bound targets on unregister, release or join, the notifier calls
> netconsole_process_cleanups_core()->netcons_release_dev(). That zeroes th=
e
> name with only RTNL and target_cleanup_list_lock held:
>
> drivers/net/netconsole.c:netcons_release_dev() {
>         do_netpoll_cleanup(&nt->np);
>         if (bound_by_mac(nt))
>                 memset(&nt->np.dev_name, 0, IFNAMSIZ);
> }
>
> dev_name_store() refuses to write while the target is enabled, so it
> never overlaps these writers. dev_name_show() has no such state check.
>
> So a read of /sys/kernel/config/netconsole/<target>/dev_name can still
> race with "ip link set eth0 name ..." or with deleting the device. The
> read could return a mix of old and new bytes, or a partly zeroed name.
> The buffer stays NUL terminated within IFNAMSIZ, so the result is wrong
> output, not an out of bounds read.
>
> This looks the same at the tip of the series. The other fields this patch
> touches (local_ip, remote_ip, remote_mac and the userdatum value) have no
> writers outside the mutex, so the gap only affects dev_name.
>
> local_mac_show() in this same series already takes rtnl_lock() to
> serialize with this notifier. Could dev_name_show() also take RTNL inside
> the mutex? That would follow the existing dynamic_netconsole_mutex -> RTN=
L
> order used by enabled_store().

This sounds correct. In dev_name_show() we need an rtnl_lock() in
addition to the dynamic_netconsole_mutex_lock(), otherwise we would
race with netconsole_netdev_event(). I will fix this in v2.

pw-bot: cr
