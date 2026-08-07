Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9B47427A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117392; cv=none; b=T8N7ib0NQKlORyi6kjLPbLzQ1IFCB7IWu+C+56QiTN3kXWrvDKAsn/yA5lPym+UrOUBprx7HJ6lm4Z8cZXI7T2NV6GLzlAWarI1qJuOkj0iduCAlZscDkp6FkPiY7bGDsJU6k5mWzEfoLnYAzBcHGrd41jkxT02Y5OIA+XgVvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117392; c=relaxed/simple;
	bh=OZUjRIHTiAh6P8HTdAvZ3IOQGeUlhZGyXxkyglHov9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+HruK/h2uVcT7UnaoKD7Oc7kdVRKuO/naewENEeI+Mfpfd8I3OKEbwYqq4bvxq3ja6EVaWSe54Q5+HE2+BrezZwpfN6453N54sdMlNrQ0Ael/mC2v0Dq6ZtxCLe0ts+qDdo//lz92tDvHK7ax2T/5IQsW43gn+2YUlKcOQJEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=kpwdXDx1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="kpwdXDx1"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so3348538a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117389; x=1786722189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yQpw629GBrjFwmfndXuo64d+zVTcLysyTqoPxM7hh30=;
        b=kpwdXDx18d5+0LyFl/HO+vowGfKdaXPkYzSPgujGNirfaxqDq+Gx349bpI4ulbLvet
         vUARQCg/s++8U5y6c2GSjyFrtNC/pm9QkEyLPKV5rzPyRbgF2UxbvcobRGazfFD5i3qx
         Fwr/UrQjtD/fkmzjZVooZv1rklpLS/lMhrwba8tqtJGpHXPRkSCbQruId7MqVLk1RmP3
         vsrFPxMY9WnCubhAEHpeYVGbQqS6az4SZD4uErGuo1a8rN60R+Xmimnpj9Ktkh3LI//J
         8ZkJ2GbsWZ8V7wCZm9l0GCWfM/B/7UPWhm40svs4FwsvF5g/rLwvNaejNBJMPT3yJXiG
         HgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117389; x=1786722189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQpw629GBrjFwmfndXuo64d+zVTcLysyTqoPxM7hh30=;
        b=mZrTRqD9nZto2NjJanH/B0hANalIOvzVOb0XYf9F8qjjzk8enUK/IW8G/ItSsHoUvE
         Xm5KGjO1vaUs7T5PaimOtxBfO38LZsaoIzsjE7bppNz5tblNZvLyRzNHjfKx+cAEq+xl
         pQfuokvjev7TWE3mUb5KdxPxOpT0pt+qh1YHi55fGgiF798dZYBTxURslH3ke/47Nrig
         3NSM2kpOrayIW9FyqUS8q1vq8sYqUszTDGnJAxR2w4CAuGW0UhUFwYuItyTLbJqCVkEC
         0VTpdNK9fiMZqLMBNA6xrNNwbYfdZU4TU1RzGeBhJlLC736awUDlROUizBuNOjCFG6JZ
         K+FA==
X-Gm-Message-State: AOJu0YzgwINADqgv+YAqs8803FjUVYp9pYhDN16Ktd554E8VU+BhhhMf
	aU4HS0YQy6oGhEvSGbqgcwoZRDV4rYV0cL1hUD9Wk+VPc/3sAnf9YvBJVFEWy+6IELgy0P7drfU
	KCt/0
X-Gm-Gg: AR+sD13kmS1ywnsTJvOHb49iwOEsihq8j1Em+dF0S6lFSLoh9L2tFSc/gkDqfWx3Ppj
	amEH08uxVJRaatY4iOHMBYjP0V/Cp1A5fG61jEp9RFKUvryb8pgrimN1vLQhVKSHWYukIVyNL3T
	ktIztVa0Xn0k4LmTPxGDZ8jN8Hj7R6kNANHAm624+QeRzCR8Y19vfvlJ9M3b1rrEU7aEpRweltm
	M7kEwLaHDFiLv0L2lkD4VnsDwS1KZFeSzrKb9Fb+sGsaWHwcBmZf2SoVWs7qZWVBmD9+33qDMcU
	Aa2dsh+RV6dI1T40F1lyHYoAFajxmCpmifleMG5WJLMqa81nvKztivnaFTTjUq3XeWDOik53xio
	PvDaCMExTgh6jsOgxIpZcl3gEDIprr++V/yTjEV/pdkopAe8fQ1XurRE2/mlKlbeR07AWNA0oIS
	xZsWp5aSnJ9fn/QdLZ7XO5Z6+3W598Xu8JnjfZUHLZQ6w3jJS4xYpcce5RxqlUZscs2Sjqg71+I
	SbRaI+xfxP2L4R1iLT1N84p1Bg=
X-Received: by 2002:a05:6a21:112:b0:3c3:bb13:438 with SMTP id adf61e73a8af0-3cbc0480f16mr6545096637.32.1786117389459;
        Fri, 07 Aug 2026 08:43:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 0/7] cleanup help and exit codes
Date: Fri,  7 Aug 2026 08:42:23 -0700
Message-ID: <20260807154306.111200-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up how iproute2 commands handle help
and syntax errors. Before, ip help command and usage
errors both output to stderr and had non-zero exit code.
Now help outputs to stdout and exits with 0.

Since help and usage errors should not happen when
iproute2 commands are scripted this should have little impact
on users. There is no POSIX or other official standard for this;
the design choices here follow the precedent in coreutils, etc.

Initial conversion was done by hand, but after that the same pattern
was applied across all utilities with the aid of the "mechanical turk"
(ie. Claude Opus).

Before:
$ ip help 2>/dev/null; echo $? # text is on stderr
255

After:
$ ip help >/dev/null; echo $? # text is on stdout
0

Usage output is unchanged:
$ ip bogus 2>/dev/null; echo $?
1


Note: a help command inside a batch file still exits
immediately and following commands are not executed.

Example:
$ printf "help\nlink\n" | ./ip/ip -batch - ; echo $?
Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
       ip [ -force ] -batch filename
...
0

Stephen Hemminger (7):
  ip: follow Linux convention for help vs usage
  ip/routel: follow help vs usage convention
  misc: put help to stdout and usage to stderr
  netshaper: put help to stdout and usage to stderr
  bridge: put help to stdout and usage to stderr
  genl: put help to stdout and usage to stderr
  tc: put help to stdout and usage to stderr

 bridge/bridge.c       | 20 ++++++++++----------
 bridge/fdb.c          | 18 +++++++++---------
 bridge/link.c         | 16 +++++++++++-----
 bridge/mdb.c          | 14 +++++++-------
 bridge/monitor.c      | 11 ++++++-----
 bridge/mst.c          | 10 +++++-----
 bridge/vlan.c         | 10 +++++-----
 bridge/vni.c          | 10 +++++-----
 genl/genl.c           | 14 ++++++++------
 ip/ip.c               | 15 ++++++++-------
 ip/ip6tunnel.c        | 12 ++++++------
 ip/ip_common.h        |  4 ++--
 ip/ipaddress.c        | 18 +++++++++---------
 ip/ipaddrlabel.c      | 10 +++++-----
 ip/ipfou.c            | 12 ++++++------
 ip/ipila.c            | 12 ++++++------
 ip/ipioam6.c          | 13 ++++++++-----
 ip/ipl2tp.c           | 21 ++++++++++++---------
 ip/iplink.c           | 40 ++++++++++++++++++++-------------------
 ip/iplink_amt.c       | 15 +++++----------
 ip/iplink_can.c       | 11 +++--------
 ip/iplink_dsa.c       |  4 ++--
 ip/iplink_hsr.c       | 11 +++--------
 ip/iplink_vxcan.c     | 11 +++--------
 ip/ipmacsec.c         | 32 +++++++++++++++----------------
 ip/ipmaddr.c          | 14 +++++++-------
 ip/ipmonitor.c        | 10 +++++-----
 ip/ipmptcp.c          | 10 +++++-----
 ip/ipmroute.c         | 14 +++++++-------
 ip/ipneigh.c          | 18 +++++++++---------
 ip/ipnetconf.c        | 10 +++++-----
 ip/ipnetns.c          | 10 +++++-----
 ip/ipnexthop.c        | 26 ++++++++++++-------------
 ip/ipntable.c         | 10 +++++-----
 ip/iproute.c          | 20 ++++++++++----------
 ip/iproute_lwtunnel.c | 33 +++++++++++++++++---------------
 ip/iprule.c           | 12 ++++++------
 ip/ipseg6.c           | 13 ++++++++-----
 ip/iptoken.c          | 13 +++++++------
 ip/iptunnel.c         | 12 ++++++------
 ip/iptuntap.c         | 12 ++++++------
 ip/ipvrf.c            | 10 +++++-----
 ip/ipxfrm.c           | 14 +++++++-------
 ip/link_veth.c        | 14 +++++---------
 ip/routel             | 11 ++++++-----
 ip/rtmon.c            | 10 +++++-----
 ip/tcp_metrics.c      | 12 ++++++------
 ip/xfrm_monitor.c     | 10 +++++-----
 ip/xfrm_policy.c      | 16 +++++++++-------
 ip/xfrm_state.c       | 26 +++++++++++++------------
 misc/arpd.c           | 12 +++++++-----
 misc/ifstat.c         | 44 +++++++++++++++++++++----------------------
 misc/nstat.c          | 11 ++++++-----
 misc/rtacct.c         | 13 ++++++-------
 netshaper/netshaper.c | 31 +++++++++++++++---------------
 tc/e_bpf.c            | 15 ++++++++++-----
 tc/f_basic.c          | 12 +++++++-----
 tc/f_bpf.c            | 12 +++++++-----
 tc/f_cgroup.c         | 16 ++++++++++------
 tc/f_flow.c           | 12 +++++++-----
 tc/f_flower.c         | 13 +++++++++----
 tc/f_fw.c             | 12 +++++++-----
 tc/f_matchall.c       | 12 +++++++-----
 tc/f_route.c          | 12 +++++++-----
 tc/f_u32.c            | 12 +++++++-----
 tc/m_action.c         | 23 ++++++++++------------
 tc/m_bpf.c            | 10 ++++++----
 tc/m_connmark.c       | 16 +++++++++-------
 tc/m_csum.c           | 18 ++++++++++--------
 tc/m_ct.c             | 12 +++++++-----
 tc/m_ctinfo.c         | 16 +++++++++-------
 tc/m_estimator.c      | 12 +++++++-----
 tc/m_gact.c           | 27 +++++++++++++++-----------
 tc/m_gate.c           | 14 ++++++++------
 tc/m_ife.c            | 16 +++++++++-------
 tc/m_mirred.c         | 14 ++++++++------
 tc/m_mpls.c           | 16 +++++++++-------
 tc/m_nat.c            | 22 +++++++++++++---------
 tc/m_pedit.c          | 22 ++++++++++++----------
 tc/m_police.c         | 10 ++++++----
 tc/m_sample.c         | 24 ++++++++++++-----------
 tc/m_simple.c         | 16 +++++++++-------
 tc/m_skbedit.c        | 17 ++++++++++-------
 tc/m_skbmod.c         | 16 +++++++++-------
 tc/m_tunnel_key.c     | 20 +++++++++++---------
 tc/m_vlan.c           | 24 ++++++++++++-----------
 tc/q_cake.c           | 12 +++++++-----
 tc/q_cbs.c            | 12 +++++++-----
 tc/q_choke.c          | 12 +++++++-----
 tc/q_clsact.c         | 14 ++++++++++----
 tc/q_codel.c          | 12 +++++++-----
 tc/q_drr.c            | 24 +++++++++++++----------
 tc/q_dualpi2.c        | 38 ++++++++++++++++++++-----------------
 tc/q_etf.c            | 12 +++++++-----
 tc/q_ets.c            | 29 ++++++++++++++++------------
 tc/q_fifo.c           | 13 ++++++++-----
 tc/q_fq.c             | 12 +++++++-----
 tc/q_fq_codel.c       | 12 +++++++-----
 tc/q_fq_pie.c         | 12 +++++++-----
 tc/q_gred.c           | 19 ++++++++++---------
 tc/q_hfsc.c           | 28 +++++++++++++++------------
 tc/q_hhf.c            | 12 +++++++-----
 tc/q_htb.c            | 19 ++++++++++++-------
 tc/q_ingress.c        | 14 ++++++++++----
 tc/q_mqprio.c         | 10 ++++++----
 tc/q_multiq.c         | 12 +++++++-----
 tc/q_netem.c          | 21 +++++++++++++--------
 tc/q_pie.c            | 12 +++++++-----
 tc/q_plug.c           | 13 ++++++++-----
 tc/q_prio.c           | 15 +++++++++------
 tc/q_qfq.c            | 26 ++++++++++++++++---------
 tc/q_red.c            | 12 +++++++-----
 tc/q_sfb.c            | 14 ++++++++++----
 tc/q_sfq.c            | 12 +++++++-----
 tc/q_skbprio.c        | 13 ++++++++-----
 tc/q_taprio.c         | 10 ++++++----
 tc/q_tbf.c            | 14 ++++++++------
 tc/tc.c               | 12 ++++++------
 tc/tc_class.c         | 20 ++++++++++++--------
 tc/tc_exec.c          |  6 +++---
 tc/tc_filter.c        | 31 +++++++++++++++++-------------
 tc/tc_monitor.c       | 11 ++++++-----
 tc/tc_qdisc.c         | 14 +++++++-------
 tc/tc_stab.c          | 13 +++++++------
 124 files changed, 1057 insertions(+), 868 deletions(-)

-- 
2.53.0

