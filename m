Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C53BA225
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500654; cv=pass; b=czF4h8v3wiNTc/LohI/Eb5mvj/QII6T9GfZSCummzdrHmvpWjabiJXmLMW4i5dNHiSScrGn7YnLVjj4XCibPWeSFyXB+WFtoo9o5/occF3dQot6iJ6F/+0yB3SI5lK0/7WrK4JLunAnBNSFhLi0kIc8//me+UFThY4UOrgkxsT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500654; c=relaxed/simple;
	bh=RfxsKW+gWzHzPnl0VGV4sp1JrOew5XduTAso8G35GXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJGnOWcB8jeLp9ANmHYhJXZXpnIY6Uh5UlSSn3UIQzL+AdnBqLcfrOs2zdCN5jT16F0SSW0DcOOkrK4NrXx9A/Wr1AR0PTssam8SwwEJtGpEaC/k2qpjHouRH162kNOSpB6s5DYYBqOmbRyghaTt0HZC+2iMAIPs+XM/g/eYS+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHQpOIQY; arc=pass smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHQpOIQY"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c7f7cc52efso57275e0c.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789500649; cv=none;
        d=google.com; s=arc-20260327;
        b=oB7Rkq1dPtVmjKN24Xq7tw3uNGaIy6WgGsFJcNddFsWYzYdICTwVa3SfT5eGtOpQYf
         IaDIksVVEnOUPWMtmRA1vRyzTw4mwZuHoDL2Zej/iLLyDSudw86Kt4v3/bNZvCDbjtdO
         paaMI2O8rXxntW5slRIoLhC1orO6JiU5/kr3wkCsLww1cm4b2E81D/Svbhp2GqE1aSdz
         70ZVy5hbtykMbT8YZs45m02P/L6WJOm15bSQ7lnipsvcS6MEz+39IwQL+Mkv4s8wZi+2
         xcPwi/RC7HL7b9sYzzubG8sMptKG3+d5OFVWYIC86Sh7VywRvNncUYc1zrK7COWMDrKH
         7Dew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
        fh=pNpmzpWQ6LrbS8uGd2YOZ2g0Ie7WI8Qi58JA5VfEH0Q=;
        b=cGb1MWsfSNMT09tCryCAXJMI3oAa2ldRz7WQ934Eh96DI7xBZb6gq50lhutHZn4S33
         18w0Dzx+AtCVhURksFAprEHIDC16AJSgZvYfvwXzBjujIZLV83vVa1KcBT6bdNq3Ozt4
         u9kc708ycxNuhVIrHqV+g+0tL2TXJNJZvc9CnOZFo8K9zQM3kvIe5Jv8Qiq4vChGPP5j
         V3cRcDxqOrbuD4ibR26/5Mp0RoClbIXMHQQ6Ay96zZsgbhj/ywsK2sL1CndG0QcToyMi
         FDyQfajVaqMYdKs9j0OpPoJhOc6AUuH1/fpok5KhMMeHOH0InPTmqPyckta9oU7AqEge
         nkYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789500649; x=1790105449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
        b=mHQpOIQYcK/f3LO6suOWFn0Cy720wLrLpDZ76Y2mpOM3+C9DQTQajqMKss2+8vswyu
         6kP5JbXC/uQnmjFeNyvbn7ykDMjEjp2433FP2tusVe+U1jFmELny3ub1VOqaeQk4+bmw
         tGfgnCt0FH77KKNFK/CBvajJjeEiwDPenSWUOdNQWc6FxW5qw9OoucUz3vPurhja7+2W
         SRX2li+U/pB+n68jTLoULDYN4LWrOMyMYUPvz3nmRdNTo7uPdox+mGt4Z2VuXMis+C7M
         e3WQC4JCEtRXPwtZDWEutENmL8gBQ5snBkXOOLsO675Xs4UrytQv+QbVij8iLiq/Acss
         xb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500649; x=1790105449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
        b=YkYF4hv6q25DF6HUaREQ05iKy4435/nmHI017K7d29ZFd/NVZSX2BlpsYNq421q9TT
         DAfBfFpVHCqm3TBvFZbGdsD6kvZ+gOA9w28b1OC2FOuIMa0zOImK9zSroGhpEQsa8kGR
         FVw5jbNTSxwNQ+I4iRg0QASZk2miaal9cGrF/B5OGJq+TGWNdF6k/WueNijHDz/fy7y7
         AX31z5dVT690Lua9bRU/afoUzSLodkrjo1eXh9dmzBlpYcpM9UtOukbT7doHpQDgjnfe
         KOFhir67mPz8WMSNqNuFbXgXx8E9ispytXsOqePMm6DGOfwj2WMv+ZCoHobk2ryBoQqA
         lNYA==
X-Forwarded-Encrypted: i=1; AKwUvBw1IwA0f9EqJmCbJ6plZGbgkCWsKxRn9NAZjCj7d5xpJ5tDvI57AGlZQ7WTP0L2DrBn8gGul6k=@vger.kernel.org
X-Gm-Message-State: AFuF++kQKZFvJrim4qz2lxJDLwJO36xeb44lqpaC5n/zoyITdZ1wOfVu
	28OZfaEhIY/2m6JJ1iogmAfWyyojRh81v2GlM6hQks2WufdP4XUzqdl42u1Koa+5K5t4wfDBmQ8
	lrYNpvQILLnes4Pqk2LprTYyffQQNEb4eIWrDSK4=
X-Gm-Gg: AYBFou0RqKGFLD2lE2k9C0HFARywqCtkO5eDc99wr70Wg1mLStAOapdhm+2BTmit4ya
	MujucqGr0HD/ydszTLdEjm6B+RUWGoHSz6dPCzfo9FEsqFVw+sf+qpQX5uoTClrbdIjANr8NNKx
	Fs8Y0SyboVOwIm50kfxW8HN7m7c0Ap3MxGAnslI6j9zQhpy8SzbET0LGqM0v7UD0jN/Ft6GzeV5
	GJxkK0e6ZT5Bu8HNK0KXEzO321FG3Wi3sh5FIJuBpDrIOpvPqnQI3fCx8LlGb2iRTs0dFjJr1D3
	EjZo2Db1P7YAyPgMkEp+BdiawslqzsQKsy20dpBlMWQqk2m8yO93jHz3TvLDM0WsrzIRc+yrfS3
	/bWlz0QOWRwABVlDVJwDOrMxy9u2VCtxxlMvAx7A1AxP+QgETwuUnAWdfE18HIX0=
X-Received: by 2002:a05:6122:8d4:b0:5c8:3697:9289 with SMTP id
 71dfb90a1353d-5c993b49b7cmr4231155e0c.8.1789500648289; Tue, 15 Sep 2026
 12:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com> <20260915081910.4142719-22-morbo@google.com>
 <202609151147.C5B45CB@keescook>
In-Reply-To: <202609151147.C5B45CB@keescook>
From: Bill Wendling <morbo@google.com>
Date: Tue, 15 Sep 2026 12:30:31 -0700
X-Gm-Features: AcwNN1W7vYosDgc2DMy2_OinBNj1qeEQ35WOY6PL8-NHlzjaHMOKmE1leyIGWNs
Message-ID: <CAGG=3QXYtmJqE5oy5ZD0-G0=GNxK71KKYurusNJvLQNqR-o6+A@mail.gmail.com>
Subject: Re: [PATCH 21/28] NFS: nfsroot: Refactor root_nfs_cat() to use snprintf()
To: Kees Cook <kees@kernel.org>
Cc: nikitash.mariiaw@gmail.com, linux-kernel@vger.kernel.org, 
	codemender-patching+linux@google.com, Russell King <linux@armlinux.org.uk>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Tony Luck <tony.luck@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Matthias Schwarzott <zzam@gentoo.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, "Martin K. Petersen" <mkp@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Thorsten Blum <blum@kernel.org>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Johan Hovold <johan@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Cryolitia PukNgae <cryolitia@uniontech.com>, Jiaming Zhang <r772577952@gmail.com>, 
	Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
	=?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
	Rong Zhang <i@rong.moe>, Arun Raghavan <arunr@valvesoftware.com>, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-edac@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-media@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:52=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Sep 15, 2026 at 08:18:38AM +0000, Bill Wendling wrote:
> >  fs/nfs/nfsroot.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> This collides with:
> https://lore.kernel.org/all/27956255dde39f58d73a7b51cb53cbe3d7804f54.1786=
411026.git.mariianikitash@google.com/
>
> > +     ret =3D snprintf(dest + len, destlen - len, "%s%s",
> > +                    (len && dest[len - 1] !=3D ',') ? "," : "", src);
>
> I prefer Mariia's version because this inline ternary is difficult
> to read.
>
Agreed. I was trying to not stomp on her work. Please ignore this patch.

-bw

> I was expecting to land hers soon if the NFS folks don't pipe up. It is
> one of the rare cases of still being open-coded, but the strlen() usage
> was pre-existing to check for the trailing comma, so it's not a clean
> seq_buf() conversion candidate...
>
> --
> Kees Cook
