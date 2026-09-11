Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF73D45C1
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092936; cv=pass; b=Yh56l3hfXFk/AJJrb7X2xX2+O94UxDC6bYtoQEkcK5zN5Y0VN7n3ezmR4eOjFimH+Zxx8YfgccLEF5J7J1j5huqMMH4hk8qzhPZGJJitO46P4ImUdPQfm8aSH9q0Y95BEnkXq2BPQRSSnvqK2h3qTlQ1uaWTMovHLxl6e/xiu3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092936; c=relaxed/simple;
	bh=8tccGjfZyb1Ob23g2fxHdhnduhVDKpCukjU+bGxqIDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgIVecbGI/uSVDvtxxyjlVOMHZiL2SqH133LeL0xk3WSMr8HTPb+o5ypqpuHDQfpDf3XF58AagOKdvCLjZsWyp3499zwHbuq/g53ys2sKuhsW0/Ie0LEkgX1Pvmci13+XgIH938hXR97B8Az54flLu3b18+Yw/da+iitHcVtYoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhpUsuRT; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhpUsuRT"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309d6188e1so5860391cf.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 19:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789092933; cv=none;
        d=google.com; s=arc-20260327;
        b=FjuO3WE0zFBFUMB6IFOs0+bR8c1fsSncR92FtOUSAvYFhAMkmaj0kHU0aNh95vw24X
         uMeZZboQnow3Rc70738MJ2VwJzCD+AxROmQrJBtbKj3nqpKMpnPLMbXAosQH+PhoqWwT
         mskZL9oXIFFNo3O6MxuEp31otnvcC8QBZk4ASgWxrpXNttDLqYd7hnH5zag2dExgWVno
         KnY3NXFVjlgKFMGu2StNUhq3a9qXAxqTIEQ9aCC2GBnEvG9uQmA91AxDoH1POK2Ej7S0
         1/HQlNqSyCxaByHtJQtFkERP9c23qqhbnRZfDShQFAPi7mXa8i2G9HJTO1CFmve3d8ci
         KonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7f0sYb6dxYG3Lz9DvyVtBVGkGbuRUaqJKogjk4Lmdg=;
        fh=1XtlfAjg6pOqkdmM2Mw5HkQT17N3Aq0Vy7tUP0uhgM8=;
        b=aADF2t03yNSoP2g3hNRqUsSWWLAZ/TeG7h+7tkaLpaNEnhUmFm7tSe0EjG0+n+ilJX
         1jZBA7/9v8gY22eKVsyOO+1KbNyodQ3fe1+HhxF+ug1wpoteZj1zkDSSjeQwUOUd8grK
         8PL4dzwr+SYsGT/bMDuPwTJpNuIR1/5L0ER0zPR5x2I/Xfk6eeeId3IwzgXK2BcntPtS
         xxN/OPZT9JKby+Q4phcYp8onj2vFmE1Bmbu0Djgd5XqNB8sw+0sgWU9oa2dpD0Ql5824
         +1x9ugyK3Lu+1Ro8lOMofCggqzoFLeLReMO+rnCBPwsJZeL1pyxb5HOAgGGKlSRJHGc/
         YAEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789092933; x=1789697733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R7f0sYb6dxYG3Lz9DvyVtBVGkGbuRUaqJKogjk4Lmdg=;
        b=bhpUsuRTAC0/5a38TteHBWqb94AFzmt8p/+8Gk4rjP6FhQ+eMfzku+DjkDfsVJzgi0
         IIoTskWShjqJdSV5UXgTpIvI9zvF74PkNB3H7JdLkBqNM2xBklGwMacfm/1tUyLJWlT8
         cLVSjnHEKUNJEtA6i2HtG2FCo7kIf1nGCtgZndNtgmQp4+MC/CrAKSXa4kG/NicUl5aG
         bCahFxvUgRW9jpHOUiMFllPuKkPNyXh3Kj4izVRRif6JzX71FZX+6pWRqh+mvco5bgaM
         RZZM/c0jIpCic+rjB1tjAkK9N+IBLd91umvBzL+vPrn9mcdrfUDSDrYA+a5koKxr8ipu
         nwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789092933; x=1789697733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R7f0sYb6dxYG3Lz9DvyVtBVGkGbuRUaqJKogjk4Lmdg=;
        b=ZdrB8J36c/7voS/+nohdrN+yr6we6VOSOnDNarJqfkXZbTgjxcKZDuAMaSODHafQLD
         IV8EQ+FzOAhu1lEnr48OaW351MOY3laxaI75o9OdirmGqQggvKqSnAqKBOLsW+oaO4Iy
         1ACG+PBx0W7fQQ2sNEp5gHU9TyRaTZxmEkXxCS2jRuH50YAGzwChHH/MEvwIsY9ZI4gC
         nJvE+9CHs+8BtS4t3qx7v3M95QYGo1eDPBK4TDPD4PGDlvL6S9w/4XX6XYUw4MH7wP4q
         IX/ttFNI7GpXv8eMIjUKMpn+AQapE5z2uJU4iHFsFNg3hTLIW6y5cjq1W38MQgDh3VQw
         ofOA==
X-Forwarded-Encrypted: i=1; AKwUvBwqhCv35XBHOp2qKaQc/WHk1eo+aszwpS5oGlCbJ9Uu007lkEbYtcjoi3aOsRkpG4IAJ6azo+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mjqjVCHqhZ69pvl8Qo9IH3JIutw6ksbYzFN8OCGGSfPC0S6qkR
	5fut93CV3A/57sDGMKAF+bhSL+yX0vatWH2XpFuQhfPjFdv2QfyiB6rwMG/08acTcUMD8e0lH/x
	7o0PmD7t7ZaIYtvX052aTWhXhLghZKDZng5yCIxOlVOjw46QH82NdI5lbRA8=
X-Gm-Gg: AYBFou2H6/mueZz0cqXzWhqtTJl8+aNX37dJnqkl1FyrK+rXpdmp2+n/sbK77TCOW/U
	HZC1mBajVXAub/2478WLssc35Wgr15y7s2dFHt2l+zYUX21KgRuQcgNo3zrT/qFiW47uPibmOPc
	4oB7Olv9GM4cmhbnW14g32ZIKJBLxtkweIhYweS3KzOUINxmM7OvjW2ZTG185+OYJfYWklar0FN
	4JLutwlz6pICdLSsEEeA555bZCtA1LDuQsZsw/YwMs2qjOTIDsSiaf2oxCZFLNYK9OmYz7oF5PM
	HGWLS751zPUjmTOsavTzrBjvxUk6OyxecvvXRQy0Gj8xcd8gf7HqmEO5/WPW6mbvDCaFnzZ4eCa
	6gYI5XJooa8PrInfsopZeXW+WqFmYTt6vENyjBssQQy+jMfb32RukPdir5TLFcIxSk/PNrtnLMw
	uWTI1FP8Ok3ccB71hGfOQ=
X-Received: by 2002:a05:622a:230b:b0:52f:bfb3:ed41 with SMTP id
 d75a77b69052e-530c870f908mr45352681cf.33.1789092932817; Thu, 10 Sep 2026
 19:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906180111.1973188-6-edumazet@google.com> <178889063414.219967.17640576039088216642@kernel.org>
 <20260909183559.24898956@kernel.org>
In-Reply-To: <20260909183559.24898956@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Sep 2026 19:15:21 -0700
X-Gm-Features: AcwNN1XKsExukVxhrgBdhqPzoNg5M0p8oPG1G-eZnyg47SGPChnwux4_SsIpaDI
Message-ID: <CANn89i+CXridHZiYOGFXDaEoubTSJHnUgjvUHJ8qqUPBNfsE2w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/8] vxlan: dynamically allocate struct vxlan_config
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 08 Sep 2026 18:03:54 +0000 netdev-bot+sashiko@kernel.org wrote:
> > - [High] vxlan_config_apply() publishes the newly kmemdup()'ed
> >   configuration with a plain store and immediately reclaims the previou=
s=E2=80=A6
>
> This and the complaint on patch 2 do seem like something we should
> address. I'm also tempted to take patch 1 via net, since we're
> close to Thursday's PR let me do that. And if you feel strongly
> that AI is nit picking please repost the other 7 after the net>-next
> merge tomorrow

Ack, no worries I will send a V3 trying to address all the feedback.

Thanks!
