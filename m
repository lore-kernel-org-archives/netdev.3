Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E440360EE5
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629776; cv=pass; b=sVA8c1r8q+twXE85647w6/Usddzvrax1Q1InIZ9K4rfZzoDmY5sN67IoMwwPKdu2EGgT+H5Ngz8RPBECq1M8a9X+o43panteaHWsSS6Qdcnzgs9iKQ4L9FJJSep4YbPZxA1EDxoYzPmBiS7sZo5W6vvg26mW2YtjVHwWAqFTKZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629776; c=relaxed/simple;
	bh=9Da5eq+pRwjTyaxE9GFmRf9JfALHj2GCu1WwH27Zlfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riHbMYwGjyiWmLK+OhF9lsgXXNEtYg8tg0BdNFEebAjMWVs8WIRtwYfVAdeux83B1EDqSVhb2Iity04P14Ro93Jl5JpkiWqkdsJrg2mwY02DUmGdFb8z8qTdZd4JrTYzCfMULDIl7z09FykLjpN3mBVq12ipg61OB/U3IX3zDls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a597uHwh; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a597uHwh"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba7ed32ccdso516142e87.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791629773; cv=none;
        d=google.com; s=arc-20260327;
        b=HoP6TJQl//eqOo1fpOro/dbAPwFPVVp34axam6Q7lRidswi7JzTJy9jxw4ZJmT68+1
         FMfCNB6ehBiQx9O+KZ8P7FwPzhZk+nSbS9s2Y1z9UgcHSJvCNQ+XJ0AZ0Da42GVg3d/w
         Fzn3wv3pXMmZ6G79oLLndaa/6IFCLzdyNq1Xd40VAS1q/gtuvPBq6zeS75Q/kVhqrIgr
         o97w92mzewNsKQFfRwFsQQsAhLltX6ZycDqI8nP6dX+22bPzWZYt6CEoiVYMCUauIhmF
         qgyH/lHMJNJq5WwKhSo7OUtd2cnZZAIAmMFXlEpliafkMUtmEbGltSBCemn9F9xJXbcq
         y96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EwmyYZEcY+97z3QJa2K7jtougNvphO7bThJRIJdzTsA=;
        fh=G53lrsyzvBxXZ+wP9lFkPkUai4aK+CApp8EMp0EFi3k=;
        b=NzR1V6pUgofbot4xHfUfH5PPFLOafPUgKLDC5CPhH6+mt4FtBgv9RHxYr2kt6Y6rop
         4lB2OhCOca34AzsiS4anlauZGYcGg+8l2FQL3LNEx6J9t5tX+TTAloGNEV1eNGQCy7QL
         IJ+z9CJi+ndSAO2FcXoNc62XsyPQCVxSaqvvLSKZotbJE+HQi8DGZglBV+SRyTunHaKF
         UTNOAlnHg5OxSlWJRjJwjgIBiXRV4ozHqdmzWqM/1EaIUBBPc+h/nN4LcfqENSiuVjBi
         KvbHMoSqpgILGCNSWR8qIYeQieefXu43Oe523tIK9lfS6FVQXOLiZ6p3dxxbkwwpcoJr
         nH6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791629773; x=1792234573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EwmyYZEcY+97z3QJa2K7jtougNvphO7bThJRIJdzTsA=;
        b=a597uHwhemTeZWR8sW7j7wO4elKu5/odxYLtDLwiU3q3sywQp11Am+cIG9UWWblagp
         mgit9EbAm1VXqBg2zuXykjpBEr85kBVsthgoMjfw+HJCebJGhyNFwIXnoLwcGqr62sR8
         vHiR3AZVGd52+oELnNB3qCwRRRuJWsSsmsosvm/C19SO1vMi8C/NqCkmdwWKbtb0v+EX
         t2iM6Pq1vI36kJmbKJ3dJof+PFlpICpnnV1Evg7WwBQXJrFf7sdtMLjikxl7eFfQWyT+
         7iC7RfiXTdYTsvm9nIjzdfEV1/kn1jVvUmNA/T6VSnrVBUeCHg4uPzfcQVSJ6sleTSIM
         KWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629773; x=1792234573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwmyYZEcY+97z3QJa2K7jtougNvphO7bThJRIJdzTsA=;
        b=QKuoCaXK+PIuerCcDS8HEPrRakszSMqIfiV7lvXN1IU/a0RcxBjtPl1yBlOv3dVmXN
         wbvbr2ZKtUGiLcrsF9yA+8cuBWwo/pfjB2bADE4Jdn/aJBN7MjxJYTqkAlvhrPsqvQSt
         Fd1LM3LLNadSh0jV3nolBASVZFGL/3dewdRTm0VAEqkD8m6pr3zImQbzrfl2/v2UUdg/
         ViCnrid5ig+L1FTRcQVmYAE/HnJPC/OaI0A6G+TO5N0dxn6BYaGQpxJoA1gAEmQHlgge
         /A0Pj6B2e3ZHc7cbrOmWnY8H1X9BkSTY1na8ZUgWzHHcHaAwh4ZvbxaVCosrZg3N9Jcp
         1QAg==
X-Forwarded-Encrypted: i=1; AKwUvBy2Ul9/3k5IDSy7mF1JxNuh0SLT9pIoo9jIXWfAUHEU3LboXJMBAtlVKKFoS93jgo5UlnhEMEA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsuTOoGngecXrW2r4udeVMp6elX+m2hknnoAjy1xYBnzGgXwUl
	eSh/TVbxurWBTh1AIfWp/nTr0I+95gonxEuwr2kRJ1YBrdIfFKIdL+iUey/iN1vu20YFQwspJU9
	t/4kbTkVymKZNjdaOdIUok+1SMaZbxNk=
X-Gm-Gg: AYBFou2Wm0MNWcT12oMaOsQB1MbyN3ZX/A/se3osUrw2RAyJRPog31x04szkG42f20t
	MouEQoVhXoGtRKAnVbA/sZgJEHzYRXJ8Z7XST2sAKvKciBpW0Rahy4Am7MDTLtLX11t2mr6PVrt
	PS93kQ+lxwl3LF+ke5WbtsITyYpDWHsrFGU4J6nM88fAwfEt/DthEupwKL6O8PeDEYsGPWyOa9i
	VmaxrnGktuhVXTDiGos24vxlnCjmdiYYp3qhQMXpSOA9oT9bISVZLb/80C6nd6RlmLrKC4fvggB
	W4dmGSzXerUDL/gi00aDk4HfEmT5GdVHxviBNttSmIdcKwMJ5pQyot8v
X-Received: by 2002:a05:651c:2221:b0:3a9:9a2e:27fd with SMTP id
 38308e7fff4ca-3a9c484ed2emr11869651fa.0.1791629772770; Sat, 10 Oct 2026
 03:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009060615.4177402-4-anilkaushikwireless@gmail.com> <179161330683.434549.12632469070516169474@kernel.org>
In-Reply-To: <179161330683.434549.12632469070516169474@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Sat, 10 Oct 2026 16:26:00 +0530
X-Gm-Features: AclHuK_l6q0YlCGBbgtN1vn_svru5QUEHDq6mx7AewQXMeHmNf5JgT_liWwt9KM
Message-ID: <CAG0Mgm8mh=xv5_dT_kLewnQYEhxsZ0bR38F3cQHW9BQ8VwOXgg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] selftests: net: add a test for the gtp
 netlink family
To: netdev-bot+sashiko@kernel.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, donald.hunter@gmail.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, all four are valid and fixed in v4
The echoreq request now matches gtp_genl_send_echo_req() and link is
in the getpdp reply
The test creates the gtp device before the family handle (and skips
without GTP).
And del_unknown_pdp checks ENOENT for both the TEI and MS-address lookups.

On Sat, Oct 10, 2026 at 11:51=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new test aborts with a traceback instead of running or
>   skipping whenever the 'gtp' genl family is not already registered.
> - [Medium] The `echoreq` operation in
>   Documentation/netlink/specs/gtp.yaml (lines 159-165) declares its=E2=80=
=A6
> - [Low] del_unknown_pdp() in tools/testing/selftests/net/gtp.py uses
>   `with ksft_raises(NlError)` without checking the errno, so any netlink=
=E2=80=A6
> - [Low] The getpdp `&pdp-reply` attribute set in
>   Documentation/netlink/specs/gtp.yaml (lines 138-149, used by getpdp do=
=E2=80=A6
>
> --
>
> selftests: net: add a test for the gtp netlink family
>
> This adds a Python selftest that drives the gtp generic netlink family
> through its ynl spec. It covers newpdp, getpdp and delpdp, a two-context
> dump, and a delete of an unknown context. It also adds a GtpFamily ynl
> wrapper, CONFIG_GTP=3Dm in the net selftest config, and Makefile and
> MAINTAINERS entries.
>
> > diff --git a/tools/testing/selftests/net/gtp.py b/tools/testing/selftes=
ts/net/gtp.py
> > new file mode 100755
> > index 0000000000000..fcc9bf57a663f
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/gtp.py
> > @@ -0,0 +1,85 @@
>
> [ ... ]
>
> > +def add_del_pdp(gtp, ns) -> None:
> > +    """Add a PDP context, query it, then delete it.
> > +
> > +    The query must return the context with the TEIDs and addresses
> > +    it was created with, and it must be gone after the delete.
> > +    """
> > +    link =3D _add_gtp_dev(ns)
> > +
> > +    gtp.newpdp({"link": link, "version": 1,
> > +                "i-tei": 0x100, "o-tei": 0x200,
> > +                "ms-address": "10.0.0.1", "peer-address": "192.0.2.1"}=
)
> > +
> > +    pdp =3D [c for c in gtp.getpdp({}, dump=3DTrue) if c.get("i-tei") =
=3D=3D 0x100]
>
> [Severity: Low]
> This dump is decoded with Documentation/netlink/specs/gtp.yaml. That spec
> was added earlier in this series by "netlink: specs: add genetlink-legacy
> spec for GTP", and its getpdp reply leaves out link:
>
>         reply: &pdp-reply
>           attributes:
>             - version
>             - tid
>             - peer-address
>             - peer-addr6
>             - ms-address
>             - ms-addr6
>             - flow
>             - i-tei
>             - o-tei
>             - family
>
> But gtp_genl_fill_info() always emits it, in every getpdp reply, dump ent=
ry
> and notification:
>
>         if (nla_put_u32(skb, GTPA_VERSION, pctx->gtp_version) ||
>             nla_put_u32(skb, GTPA_LINK, pctx->dev->ifindex) ||
>             nla_put_u8(skb, GTPA_FAMILY, pctx->af))
>
> Should link be added to the reply attributes? Without it, consumers
> generated from the spec can't tell which gtp device a dumped context
> belongs to.
>
> On a related note, this filter matches only on i-tei, not on the link the
> test just created.
>
> > +    ksft_eq(len(pdp), 1)
> > +    ksft_eq(pdp[0]["o-tei"], 0x200)
> > +    ksft_eq(pdp[0]["ms-address"], "10.0.0.1")
> > +    ksft_eq(pdp[0]["peer-address"], "192.0.2.1")
> > +
> > +    gtp.delpdp({"link": link, "version": 1,
> > +                "i-tei": 0x100, "ms-address": "10.0.0.1"})
> > +    ksft_not_in(0x100, _iteis(gtp.getpdp({}, dump=3DTrue)))
>
> [ ... ]
>
> > +def del_unknown_pdp(gtp, ns) -> None:
> > +    """Deleting a context that was never added must fail."""
> > +    link =3D _add_gtp_dev(ns)
> > +    with ksft_raises(NlError):
> > +        gtp.delpdp({"link": link, "version": 1,
> > +                    "i-tei": 0x999, "ms-address": "10.9.9.9"})
>
> [Severity: Low]
> Should this check the errno too? ksft_raises(NlError) accepts any netlink
> error. For example, -EINVAL or -ENODEV from gtp_find_pdp_by_link() or
> gtp_genl_del_pdp() would also pass. The real lookup miss in gtp_find_pdp(=
)
> is -ENOENT.
>
> Also, both delpdp requests in this test send ms-address, and
> gtp_find_pdp_by_link() checks that before the TEI branch:
>
> drivers/net/gtp.c:gtp_find_pdp_by_link() {
>     ...
>         if (nla[GTPA_MS_ADDRESS]) {
>                 __be32 ip =3D nla_get_be32(nla[GTPA_MS_ADDRESS]);
>                 if (family !=3D AF_INET)
>                         return ERR_PTR(-EINVAL);
>                 return ipv4_pdp_find(gtp, ip);
>     ...
> }
>
> That means the i-tei values passed to delpdp are ignored, and delete by
> TEI through gtp1_pdp_find() is never tested.
>
> With the current kernel this request does return -ENOENT, so the test
> passes for the right reason today. It just checks less than the docstring
> suggests.
>
> > +
> > +
> > +def main() -> None:
> > +    """Run the PDP context tests in a temporary netns."""
> > +    with NetNS() as ns:
> > +        with NetNSEnter(str(ns)):
> > +            gtp =3D GtpFamily()
> > +        ksft_run([add_del_pdp, add_two_pdp, del_unknown_pdp], args=3D(=
gtp, ns))
>
> [Severity: Medium]
> Can GtpFamily() succeed here if gtp.ko isn't loaded yet?
>
> GtpFamily() -> YnlFamily.__init__() -> GenlProtocol('gtp') looks up the
> family id with _genl_load_families(). That sends CTRL_CMD_GETFAMILY with
> NLM_F_DUMP, which the kernel answers from ctrl_dumpfamily(). Only the
> non-dump ctrl_getfamily() path autoloads the module:
>
> net/netlink/genetlink.c:ctrl_getfamily() {
>     ...
>         request_module("net-pf-%d-proto-%d-family-%s",
>                        PF_NETLINK, NETLINK_GENERIC, name);
>     ...
> }
>
> This patch adds CONFIG_GTP=3Dm to the selftest config. On a fresh boot wi=
th
> that config, the "gtp" family isn't registered yet, so
> genl_family_name_to_id['gtp'] raises KeyError. YnlFamily.__init__()
> turns that into:
>
>     YnlException(f"Family '{self.yaml['name']}' not supported by the kern=
el")
>
> That exception isn't a KsftSkipEx and is raised outside ksft_run(). Won't
> the whole script abort with a traceback before any case runs?
>
> gtp.ko would only be autoloaded later, through the rtnl link alias, when
> _add_gtp_dev() runs "ip link add gtp0 type gtp". For the same reason, wit=
h
> CONFIG_GTP unset the KsftSkipEx in _add_gtp_dev() is never reached, and t=
he
> test fails instead of skipping.
>
> Would it work to create the gtp device, or otherwise load the module,
> before constructing GtpFamily(), and to treat a missing family as a skip?
>
> > +    ksft_exit()
> > +
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main()
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/=
selftests/net/lib/py/ynl.py
> > index 08deff756f29b..7edb749710231 100644
> > --- a/tools/testing/selftests/net/lib/py/ynl.py
> > +++ b/tools/testing/selftests/net/lib/py/ynl.py
>
> [ ... ]
>
> > @@ -85,3 +85,9 @@ class PSPFamily(YnlFamily):
> >      def __init__(self, recv_size=3D0):
> >          super().__init__((SPEC_PATH / Path('psp.yaml')).as_posix(),
> >                           schema=3D'', recv_size=3Drecv_size)
> > +
> > +
> > +class GtpFamily(YnlFamily):
> > +    def __init__(self, recv_size=3D0):
> > +        super().__init__((SPEC_PATH / Path('gtp.yaml')).as_posix(),
> > +                         schema=3D'', recv_size=3Drecv_size)
>
> [Severity: Medium]
> This wrapper loads the gtp.yaml added earlier in this series by
> "netlink: specs: add genetlink-legacy spec for GTP". Does that spec's
> echoreq request match the driver? The spec lists:
>
>         request:
>           attributes:
>             - link
>             - version
>             - peer-address
>             - peer-addr6
>             - family
>
> gtp_genl_send_echo_req() requires GTPA_MS_ADDRESS, which isn't listed:
>
>         if (!info->attrs[GTPA_VERSION] ||
>             !info->attrs[GTPA_LINK] ||
>             !info->attrs[GTPA_PEER_ADDRESS] ||
>             !info->attrs[GTPA_MS_ADDRESS])
>                 return -EINVAL;
>
> The handler is also IPv4-only and never reads GTPA_PEER_ADDR6 or
> GTPA_FAMILY.
>
> A client generated from the spec would never send ms-address, so its
> echoreq would always fail with -EINVAL.
>
> That spec commit says it is "derived directly from include/uapi/linux/gtp=
.h
> and the gtp_genl_policy / gtp_genl_ops tables in drivers/net/gtp.c". That
> doesn't seem to hold for echoreq.
>
> Should ms-address be added to the echoreq request, and peer-addr6 and
> family removed?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261009060615.4177402-1-anilkaushikwireless%40gmail.com
