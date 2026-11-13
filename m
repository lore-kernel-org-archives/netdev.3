Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557854;
	b=oXTpPYJBeoNrExEYFi5Zv9M9cARLlFhbvtL6Q6HhkPAQo7zvq1v4KJ7KSdvpX/q+oWF+
	 QBBnD8iw3cQog2SL4QFzl+PUDmCMqVVPQjl5dp8vNmpCOg5fJ2eT/5vxpTRh1ftYnJX6S
	 3o92Y+/2qQaTV4ss5ChT2HvUSlD5j+ZOg6UIMuAHAATfqt0GC78GE+lXa2lXsJWYs7K07
	 0ZgWuXVb5YLSok0edmV5Y/uI37wn/EiIPb1go5IGxQqHnc4KK3iqflZqzwLF+Owm2kUsW
	 49Z+MhLBjbWNLFeF21JNsO74jFJVhaR0QAe9kbMv+fV5sfhxx/eO4Vysyd2/pLjLJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557854;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=cuEAytbsYP/4/ltxThuyv6bPkB2E6ZFm0msbijvroMw=;
	b=p7TenIPMShYHz6cjIHVSCAZhAeeqfc19loikLvFywbFfBzflNGJe7X/ZDBgwm7nzlNcZ
	 ldGwJce82xfSnLqjY/o6/78MXJXv73mpTsse9HI8qUavvNoaQQH5n6hZRcpf9WVGQk2Sh
	 e0x2VswyfCqbeX3bJ/V6FgO26aQgwwRyE4EuulFWkF2Yu1eAawj7ZMh4o2yCrB+CgX2BD
	 HxigTNXSa8sgFuezbWf+4+7RXmXwQXJ833+hWq8aTW18wNxc0zyYZ/LQkrp1F8c8P9wv4
	 XvVMdEOX4UntafHCfNHXl9MlZf4FgvVLLqf5A0j5onQxwIDD6+K34LAvJDhFCuerTnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=net-swift.com;
	spf=pass smtp.mailfrom=net-swift.com;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61828606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61828606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1794557775t21d683c7
X-QQ-Originating-IP: LM8VgeXyT2TO9ZkEvFH44Ykg3y91AEB1bOMIwox6gwg=
Received: from smtpclient.apple ( [122.233.169.80])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 16:16:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3816878505855276113
EX-QQ-RecipientCnt: 14
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v8] net: libwx: fix VF PM suspend/resume flow
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <179421969986.488859.13582406441576044740@kernel.org>
Date: Fri, 13 Nov 2026 16:16:03 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 hramamurthy@google.com,
 jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E18B9474-0EB4-400D-B8F3-6375E4BB7D30@net-swift.com>
References: <20261109101442.84605-1-mengyuanlou@net-swift.com>
 <179421969986.488859.13582406441576044740@kernel.org>
To: netdev-bot+sinfo@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Ob0dgDnypcmJ16hND6P4pgTgWk5FjGXDB2BFQJ+hQT8tjktiqe/YUQKy
	zOk/RCAw6IjNsOKM0SfSt8LEU34lGHgf0b4ghss6+Y0yclIS1qxs4aaB7qJMN4VqKPyA3uy
	Dbx3FSJpmyo1TSN+PjhApkQmVMsfhbeJc2oapf2FCCADhZmfP0ktEo4K9w8c2c082GxDGI6
	thvEeLcM8YFU/BCQRvp+DKhAdM0Jc2xtx5Xqh5NVg+PxS9KWuBzCn3tgo6uHueLo7QcNuio
	LORLn9PEgWy6sXcdWYvNCaCp9xoF7AKutXfQeKWMmVF7RRL7UbW4AgOAMwFlna4ZO+mlY/r
	tdu4Pp0R05nC0Cy5auUtQEF9mqJhvth2ojexk5wEpJL8JcSTdS9T+PuvMWP/kEFptO7scGv
	r6p1ekjQFMQjANSpVYFt+DpkHes88VChyX+Hi9/Y74rBA+YxBEjqiZRiXIZgq6ZCQGyq/+8
	GtpUupcLRJv34lcQy6cyL2btCaq9wyq7fp7u/9s3DCOFgmAb5C5A/OaRLCUrQ5WX08iAVDf
	FIGqB3+yFjHJl14Td5RhG3I4L3Jj79P2WGJIIPdWm6Menlxu83JOlYwBUfGfBBXem0jvreB
	M5dFZ4/41GxwmFT9CfTHR0xpQwE0BNoYboqEWgqfNe6O4lmmfr2VxeQe0Pku4fRdCcyfBOF
	P+g09BKJSoYeu6QcGiqvBrkDYsXNYmI9myOYhMUI7cyz+tZ4lXcT7znaGsGkRf+5Tm3opdM
	Q4rCWZC0bYnF5Wl34cyE/oKS72WO8L8pzSiXNsGE6XRlLf286xKSGbmdowGoklsTSLEVU3d
	qX6d/BXgzJdv+YRxfka+NMy0m0LJ7zsr/nmizLc5AvdhpP4A93juj3GgGH3aMRpoui4lUjQ
	EUNQSDWtxt8Ku96YLE7aYgF7IUFT+pJ46m9uRXkJIZCEdnfGolq2oTZ4BrM7sjmsLPD8e7+
	YfBB9JdQdDrMGZb3E7Wk+DZsqD0t390mSbEgeO/T5GQTkZreU28FJPzIoDhFq3/56tp5IZj
	764NfjeKaWWxfylkYmILRfqvhetIz3G5STuHa6vo/LbciJeHmr9TCqXrLtVNLdKAMsDXNmN
	PJ8pM+CzXKMqcC6CC2cUUmgx8R4dazvjnTOSdt+PzMK
X-QQ-XMRINFO: NyFYKkN4Ny6Fq1vWQeiUdNaJ3rSwg+JQ9Q==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B411=E6=9C=889=E6=97=A5 18:21=EF=BC=8Cnetdev-bot+sinfo@kernel=
.org =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.

Discovery: The issue was identified by sashiko, a static analysis tool,
	during the submission of another patch.
>=20
> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by code inspection). If it was triggered please include
>   the symptoms, like the stack trace or error messages.

Trigger: The issue was actually triggered on real hardware.
[181301.020897] [ T651688] ngbe 0000:06:00.1 enp6s0f1: Link is Up - =
1Gbps/Full - flow control rx/tx
[181301.148619] [ T651688] ngbevf 0000:07:01.1 enp6s0f1v2: Link is Up - =
1Gbps
[181301.148619] [ T651689] ngbevf 0000:07:01.5 enp6s0f1v3: Link is Up - =
1Gbps
[181301.148637] [ T612761] ngbevf 0000:07:00.1 enp6s0f1v0: Link is Up - =
1Gbps
[181301.148654] [ T612761] ngbevf 0000:07:00.5 enp6s0f1v1: Link is Up - =
1Gbps
[181301.148663] [ T611394] ngbevf 0000:07:03.1 enp6s0f1v6: Link is Up - =
1Gbps
[181301.148667] [ T612761] ngbevf 0000:07:02.1 enp6s0f1v4: Link is Up - =
1Gbps
[181301.148679] [ T611394] ngbevf 0000:07:02.5 enp6s0f1v5: Link is Up - =
1Gbps
[181301.212894] [ T651689] ngbe 0000:06:00.0 enp6s0f0: Link is Up - =
1Gbps/Full - flow control rx/tx
[181304.648904] [   T4039] PM: suspend entry (deep)
[181304.659264] [     T12] Filesystems sync: 0.010 seconds
[181304.659576] [   T4039] Freezing user space processes
[181304.660910] [   T4039] Freezing user space processes completed =
(elapsed 0.001 seconds)
[181304.660912] [   T4039] OOM killer disabled.
[181304.660914] [   T4039] Freezing remaining freezable tasks
[181304.662058] [   T4039] Freezing remaining freezable tasks completed =
(elapsed 0.001 seconds)
[181304.662085] [   T4039] printk: Suspending console(s) (use =
no_console_suspend to debug)
[181304.668733] [ T629147] ------------[ cut here ]------------
[181304.668736] [ T629147] WARNING: net/core/dev.c:7751 at =
__netif_napi_del_locked+0xf1/0x100, CPU#15: kworker/u97
:1/629147
[181304.668742] [ T629147] Modules linked in: ngbevf ngbe libwx tls =
snd_seq_dummy snd_hrtimer xt_CHECKSUM xt_MASQU
ERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_set ip_set =
nft_chain_nat nf_nat nf_conntrack xt_addrtype
 nft_compat x_tables nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo =
nf_tables bridge stp llc overlay qrtr binfm
t_misc nls_iso8859_1 amd_atl snd_hda_codec_alc882 intel_rapl_msr =
snd_hda_codec_realtek_lib snd_hda_codec_nvhdmi
[181304.668778] [ T651709] ------------[ cut here ]------------
[181304.668779] [ T629147]  intel_rapl_common snd_hda_codec_generic =
snd_hda_codec_hdmi snd_hda_intel
[181304.668781] [ T651709] WARNING: net/core/dev.c:7751 at =
__netif_napi_del_locked+0xf1/0x100, CPU#0: kworker/u97:
11/651709
[181304.668784] [ T629147]  snd_hda_codec snd_hda_core
[181304.668787] [ T651709] Modules linked in:
[181304.668787] [ T629147]  edac_mce_amd snd_intel_dspcfg
[181304.668788] [ T651709]  ngbevf ngbe
[181304.668790] [ T629147]  snd_intel_sdw_acpi snd_hwdep
[181304.668791] [ T651709]  libwx tls
[181304.668792] [ T629147]  kvm_amd snd_pcm
[181304.668793] [ T651709]  snd_seq_dummy
[181304.668794] [ T629147]  snd_seq_midi
[181304.668795] [ T651709]  snd_hrtimer
[181304.668796] [ T629147]  snd_seq_midi_event
[181304.668796] [ T651709]  xt_CHECKSUM
[181304.668797] [ T629147]  kvm
[181304.668798] [ T651709]  xt_MASQUERADE
[181304.668799] [ T629147]  ee1004
[181304.668799] [ T651709]  xt_conntrack
[181304.668800] [ T629147]  snd_rawmidi
[181304.668800] [ T651709]  ipt_REJECT
[181304.668801] [ T629147]  snd_seq
[181304.668802] [ T651709]  nf_reject_ipv4
[181304.668802] [ T629147]  irqbypass
[181304.668803] [ T651709]  xt_tcpudp
[181304.668803] [ T629147]  eeepc_wmi aesni_intel
[181304.668804] [ T651709]  xt_set ip_set
[181304.668806] [ T629147]  asus_wmi gf128mul
[181304.668807] [ T651709]  nft_chain_nat
[181304.668808] [ T629147]  snd_seq_device
[181304.668808] [ T651709]  nf_nat
[181304.668809] [ T629147]  rapl
[181304.668809] [ T651709]  nf_conntrack
[181304.668810] [ T629147]  sparse_keymap video

>=20
> - What hardware the change was tested on. For driver fixes please
>   mention the device (and if relevant firmware version) used for
>   testing, or say that the change was not tested on real hardware.
>=20

Testing: The change was tested on WX1820 (TXGBE_DEV_ID_WX1820) and
WX1860A4 (NGBE_DEV_ID_EM_WX1860A4) NICs.


> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
>=20
>=20

