Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022089.outbound.protection.outlook.com [52.101.66.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5E4FC34E;
	Mon, 19 Oct 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417722; cv=fail; b=THtdGNzWA5pAfZ5+yhkXnZeKJzyR1ILTYueeGXz4TlGszneaTRt17TEt57ame/vHpj91RY1SxMdJClR2iupAtvPrih9Z9tipsvUHOb6ucEsnfNAsVnWrwHSoOzIyqHhsnSG+1jTh95tNXOUFrPyImy3mcvenwxp7rVAikR+4QdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417722; c=relaxed/simple;
	bh=nannDBEzBXtnjrIp837edlx5YRdAh5QPYME17Z2F2/g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nfYRcy+CSXzJqdyaiDDbfDeDTXYmj33bXaOb7uGY8Nll3s+l2Y8IuZVR+fyH97OBD9SU6wX2fXfSF2BuScT2UK5dDVWYg88e75KqZMdXPTOgWj27++0iOFpm3+Nwjju18aTd6Gn0qM57+YvcpFQD+TsB/4SpMQMjgGOTE36QSCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=visotia.com; spf=pass smtp.mailfrom=visotia.com; dkim=pass (2048-bit key) header.d=visotia.com header.i=@visotia.com header.b=jl8fT0nb; arc=fail smtp.client-ip=52.101.66.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=visotia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=visotia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=visotia.com header.i=@visotia.com header.b="jl8fT0nb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSeW6GFqcQCDGLTqC+Arw5uEZ9titp8kGRnpwZ8kmNoxTryYUJ/RNT7MVkTCIlHaiYYlqz99D8gwmYfdnUav3kmF5kzbZK93BVJJvgpHi+dzRZKuAIktRXDXJ1Xu0l51IquPuN27ResUUe5rzSO4vKsPuR+cTlIlPZmo5yGHeoOXoejkiOy/gvzcs4ex5EYt88HZpdvFwfKKN2UVSsHvm5/XQlqmlRcplbvb5lHl1LHjXFb04rWWGdMj2ZOoAGMMAIhZVLbUrY41PNKvF0D3FlW9f7IWkJwzoqjQs8OJJSZy6qNIhjH5VxLR0jWLdSgBxRbKreKrMamAYHPGYgYkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT1QF/4LMnmjmGFqGhglCbJ5NMIOT5xbRTmgGkX02Ck=;
 b=KzAemskxOkpM8YgYi1nb1I9HqbENYjO6mP7CQ5eBkhNHWSkKEqkxys1CksMz8vY76V3NW4efbVf2z2RidEjOm2c+2pTu3rBC8ghD9chT4Ui9sytxVykhqP+hggj/0a4E0bQkHQVSAQ2ETUpv9RjFwQfW+WuSV0wqLPcDhykhsnbLCDtGlMLx/5n8zjbhWNvGhvxnuV8lwscuX8WaZVC0Cxh9Vj+9Vy/2ec4ElN3Re79V4ubNu93InkPhUr01uOEpBsKhhSPcvuvO1d/0wBbo60sgPGqqZCWdifat5a8jan6ZK7shiDz++HsBp9QMO67fpIn6GWAWd7XZxL20slaYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=visotia.com; dmarc=pass action=none header.from=visotia.com;
 dkim=pass header.d=visotia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=visotia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT1QF/4LMnmjmGFqGhglCbJ5NMIOT5xbRTmgGkX02Ck=;
 b=jl8fT0nbGRay55pG2S2uwK7stCh0wpPZCxeXOSbBn8ntW+4JViifXY/bSN6J/AEGLG0ofk8QvMz7VblyvDV4gmAcKcCs8hVyTwk9SPPWuOJ6/5W0lo/rB5iwx1/7tGe8enNipLfUDALrGQB7F6uxbopqwglz45ILTsMvMPjlgywaQgXDzKrGF6fDfMHgluwsrdeds/Xp4Ne/G0HsKTt0GzVy28WRsG4WG3vVfkr27dfgzwfzNDDVydgjA3UeeiSokybSK/CkWdPBvAfF5i+spLVHudfJ1RilceB1q8J8znpSEOsePX6y1qDn3P8SW9/FCz5sbj+8g1TSoVKDkGRpBg==
Received: from PRAP189MB1850.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:27b::14)
 by VI0P189MB2700.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:236::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:48:37 +0000
Received: from PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
 ([fe80::5cce:ff09:8d2f:9cad]) by PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
 ([fe80::5cce:ff09:8d2f:9cad%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:48:37 +0000
From: Mikkel Eskildsen <mke@visotia.com>
To: Oliver Neukum <oneukum@suse.com>, Breno Leitao <leitao@debian.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [BUG] cdc_ncm: soft lockup with netconsole over an AX88179B dock
Thread-Topic: [BUG] cdc_ncm: soft lockup with netconsole over an AX88179B dock
Thread-Index: AQHdX9CKh0EMeyYVbkas70+IWBbMnw==
Date: Mon, 19 Oct 2026 13:48:37 +0000
Message-ID:
 <PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-DK
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=visotia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1850:EE_|VI0P189MB2700:EE_
x-ms-office365-filtering-correlation-id: 712e498d-3420-4b2e-b056-08df2de7ad39
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|260925021911599003|260925022911599003|260925021311599003|261009223027099003|10067099003|56012099006|3023799007|6133799003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 Lvm5WJdmRnH22VNVqYKvpX1ZjohbSbVLyuGaoKtrzQ8eaAoB296eLBCDi+qkWHgqxPMU7nuXtCBC30X3Vkqymaj1QE5SluoK0Ze9Lz0+Iua8Q1WfeUiWINGlKBYJczJ0et5zC4RPpQrLxCDSOdejKDUKryUQq/Ek4R/tGJtTXHTQaKGC1Dj43XcdcJOSybCrYrWhMWnPGIRHdikqx592lVnMhV0gU7kJ5k55jg49++vnZMZoKtsNI6Ft+xgOVzyBfHqZGyZs2EWOdCcIPHyEd+avgVKOjOXRicXFCoANQKOUPfzcEc1DFgGzGR8t8NvVpYefkVSeu0STVIbSIhS304n6vfpqLSpT7P6p2AiaVRVr1BrtNOdOFitPAbjUUojUsM7KW+utKCOe/Tu0kaTWAhFufv+6Yenk1+RjOZUu4eO07fTWVkUXhc1ltAH/CEKXC/jt5PuEovvtuxuKxLKETzJYUUvuI14uf6lFyRK9YAiV+nNt1wuetoAiZ+yxF4T9pPXL4Y23wmDvmZtJuzP1lJ6vuu+44p68I9pc+WXetFaOtNV9uFaT3+sdGKqxfOfQuG36gCRnlJ5PVb7ql+WReFGhEsb3BFwzzWkz1AoF3SM5NVydx39CBVHszuhLHJGV/QqxQgvQ1SF52bda1oXqifxs+NbKctfeVm+1ZeIOQcYDpUSkDfiEaixt0NKdcXt8up/xHHD3InfTUzakIr2scCatPpQ1S8IWJNxKyKoFHCM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1850.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(55112099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HALf8S2X4P9QX1gU09VVoXM4iwrv4JFJp/ivXscDmz83hYvNk6CMiHNXugr3?=
 =?us-ascii?Q?sywJxfOA5odiavrNbu3xayiCJ2tByXZdypzEYgZnj4adS4NiLvo2QuFT7EDp?=
 =?us-ascii?Q?YQhROufVCimQNd5sdztynptcHxlPKMMd4PU3M+FTHWw/FxlEN1c2DCVeLMbA?=
 =?us-ascii?Q?YOOKmmFBTB/7skEbk4iHVbKkI9sVexa+cjZubIJaGOiWQgI9IjAZOM1s2SDV?=
 =?us-ascii?Q?MVMHM//iBvZiYi1iQeOwWQPeRIQyMR4QzFOVKtb6HHYKUjUuJ2adWQPymUeS?=
 =?us-ascii?Q?n+9EeFFGSWOCE6q6xPSUHzIulWf7g8n8KNMPHSc9AAEg5QbWgkJ5mOJoOBX5?=
 =?us-ascii?Q?qWnu/AtnmV0v+D6sIYEiZgUAY9vCeg55GvTlijgnb/Gxs+MzJqyCh/81a5zZ?=
 =?us-ascii?Q?wKgHadaCVxW5fnzFnap9b2rxumpucrGq1aB+rmlidiBQ4/uKBWwoIN02saNd?=
 =?us-ascii?Q?YGN9aUw4/pGAZJIyd/VeA1Chv+0eCcYY5dDs9bfsnO3I+kg3OLuIeINcuAiB?=
 =?us-ascii?Q?u1heXuk4cN6a+pF4qZE3EmTZETdJsv2mc6jCv3ReJphp3yUsY1fJwzmpPezL?=
 =?us-ascii?Q?4Ueurwb0PlqZssGToUoGdriKb0MIb/TPx1lwsKnKTagt8XCVEFsdbmg6rmQB?=
 =?us-ascii?Q?HcdjGtjSx8R+lbj7pmLQXJtDVnRXmEOLCjp5oqIl+yAJ2+7vFEUR/6egp8K/?=
 =?us-ascii?Q?o3alDR1s8NSHdgR+fOtMIDnXNQ9GrTWWN1qEKz8oVYjpigTkFTGut8fNQlv6?=
 =?us-ascii?Q?Mn/9Xca+PpmXjz0i+29z59SMYg8TyUV8t6RXFkJ0pBu4fB1V8ebkPsTdilXH?=
 =?us-ascii?Q?PBzGqHrKVGYXFBUnRPxDNkwjTE8a6bVC7tQBjnwidQXPO332mVYh6AndKieV?=
 =?us-ascii?Q?VzkNwTN01WA0yFi4HyRbXUdBQ7H3IZiztZ6czbMnxC8g7s3pXlQkmH5hOcdQ?=
 =?us-ascii?Q?RlIgrzrsnhYudi7dnBNBmyAf/wuzFHqexXzXy0QB/nke+2xJSpW/qEYr5cOy?=
 =?us-ascii?Q?m0H+CF1Y/DUPxBPm8JtYZl6X3gmrr8PHd/pOzeAjSxRfuSjphucspcywbr4w?=
 =?us-ascii?Q?3qcFCdRNn+9fRzhtcMCFtNKzwMf9RUUwoxxvxEAWs5cW8Jx6EFbHtFE5Ak7c?=
 =?us-ascii?Q?1acb6Py3Q+F0svYuX526hJSJZ6nr03inj4VYw1VCRA6DZasyinMmdXGu1+Yp?=
 =?us-ascii?Q?SBPsGtaq/55KcZ/3T0HNETzfCWmqbVp2fw4e2m3PCAINXk6r+RNFiKzBJ0eT?=
 =?us-ascii?Q?qbp68nDCi9PE//am4L9gZvrw/WzxMSzm2UGXD8h9BBgQDQqFMtnC53Ukqpzo?=
 =?us-ascii?Q?f1Kw0XJcMgvvaPMpnOi0OXIS16F5PwanzKQvHzeX34ZeIjbe+7vGw2FrwGkm?=
 =?us-ascii?Q?MFpvDIAIGOQn/CkRG+nvilRaiV9CUJN3nDIYqozQqUF/YUTQLd425HyUkd0p?=
 =?us-ascii?Q?1mf1eWH4XGZAmGZVwD+kyXUW2D44Ze+jgkQMJJ8pdfmGdZweScbn0+MTHhU8?=
 =?us-ascii?Q?9RejeHXPn7op9u/eRaGPLsfr2FG0bx1RhIbrlHCUhBrwkulVsq6o8h53wwIZ?=
 =?us-ascii?Q?qxpZ+p7oSnzcBiECAbeIo0T66bRnPtuNaCmpOyMcnhWVF1CuD5xw5XmPnYhy?=
 =?us-ascii?Q?9+L1wKjVg+lcWVfo1QqgO/OcdMOReMRd3C/WYhnnjSffLWEklN8EKtAR1soC?=
 =?us-ascii?Q?G0s2B99hDIym9tUoFm5E8gaIeErSGDCsLf49ENB6q/Z12qQq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: visotia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1850.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 712e498d-3420-4b2e-b056-08df2de7ad39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 13:48:37.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0398e9f1-d93e-448d-9e92-963c448c9a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlbysGoP0L9egwkEh6clVNFZQYGIVRqCAgzxZNInSlbdaXz0Moq5sp/NERW1hsaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2700

Hi,=0A=
=0A=
My laptop panicked with a soft lockup on 2026-10-16 and again on 2026-10-19=
 while netconsole was running over a USB dock NIC that uses cdc_ncm. Both t=
imes the laptop was docked and netconsole was on that interface. I have tur=
ned netconsole off for now.=0A=
=0A=
The trace below is from pstore. The netconsole thread on CPU15 is in netpol=
l_send_skb -> usbnet_start_xmit -> cdc_ncm_tx_fixup. The spin_unlock_bh() i=
n cdc_ncm_tx_fixup runs pending softirqs, TCP RX sends a packet and it spin=
s in sch_direct_xmit. My guess is that it waits for the eth0 tx queue lock =
that netpoll already holds. The other CPUs then wait on the socket lock unt=
il the watchdog panics.=0A=
=0A=
The first panic looks the same, but pstore lost the part with the netconsol=
e thread.=0A=
=0A=
I have not tried mainline, but cdc_ncm_tx_fixup and netpoll_send_skb look t=
he same there.=0A=
=0A=
Kernel: 7.2.9-1-cachyos, PREEMPT(full)=0A=
Machine: Lenovo Yoga Book 9 14IAH10 (83KJ), BIOS QECN29WW=0A=
NIC: ASIX AX88179B (0b95:1790) on cdc_ncm, in a USB dock=0A=
netconsole: one target on eth0, kernel.printk =3D 7 4 1 7, kernel.softlocku=
p_panic =3D 1=0A=
Taint O/E is a patched out of tree wacom HID module for the touch panels.=
=0A=
=0A=
[271447.258658] watchdog: BUG: soft lockup - CPU#9 stuck for 13s! [python:3=
582585]=0A=
[271447.258667] CPU#9 Utilization every 2000ms during lockup:=0A=
[271447.258669] 	#1: 100% system,	  0% softirq,	  1% hardirq,	  0% idle=0A=
[271447.258672] 	#2: 100% system,	  0% softirq,	  1% hardirq,	  0% idle=0A=
[271447.258674] 	#3: 100% system,	  0% softirq,	  2% hardirq,	  0% idle=0A=
[271447.258675] 	#4: 100% system,	  0% softirq,	  1% hardirq,	  0% idle=0A=
[271447.258676] 	#5: 100% system,	  0% softirq,	  1% hardirq,	  0% idle=0A=
[271447.258678] Modules linked in: ntfs3 wireguard libcurve25519 ip6_udp_tu=
nnel udp_tunnel cp210x tcp_diag inet_diag uinput rfcomm tun ccm snd_seq_dum=
my snd_hrtimer snd_seq nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4 nft_r=
eject act_csum cls_u32 sch_htb nft_chain_nat nf_nat nf_conntrack nf_defrag_=
ipv6 nf_defrag_ipv4 nf_tables bridge stp llc netconsole algif_hash algif_sk=
cipher af_alg bnep snd_usb_audio snd_usbmidi_lib snd_ump snd_rawmidi snd_se=
q_device hid_sensor_custom_intel_hinge hid_sensor_gyro_3d hid_sensor_accel_=
3d hid_sensor_custom intel_ishtp_hid snd_ctl_led snd_soc_skl_hda_dsp snd_so=
c_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common snd_h=
da_codec_intelhdmi snd_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_re=
altek_lib snd_hda_scodec_component snd_hda_codec_generic snd_soc_dmic snd_h=
da_intel snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel sn=
d_sof_intel_hda_sdw_bpt hid_sensor_als hid_sensor_prox hid_sensor_trigger s=
nd_sof_intel_hda_common intel_rapl_msr kfifo_buf=0A=
[271447.258727]  hid_sensor_iio_common snd_soc_hdac_hda intel_uncore_freque=
ncy intel_uncore_frequency_common snd_sof_intel_hda industrialio snd_sof_in=
tel_hda_mlink intel_tcc_cooling soundwire_cadence snd_sof_pci snd_sof_xtens=
a_dsp x86_pkg_temp_thermal intel_powerclamp snd_sof coretemp snd_sof_utils =
snd_hda_ext_core vfat snd_hda_codec fat snd_hda_core ucsi_acpi kvm_intel ty=
pec_ucsi snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks roles iwlm=
ld snd_intel_dspcfg typec snd_intel_sdw_acpi soundwire_generic_allocation s=
nd_hda_scodec_cs35l56_spi mac80211 mei_gsc_proxy snd_soc_sdw_utils snd_soc_=
acpi kvm snd_hwdep soundwire_bus ptp snd_soc_sdca irqbypass yogafan pps_cor=
e aesni_intel libarc4 snd_soc_core gf128mul ac97_bus aead snd_hda_scodec_cs=
35l56_i2c snd_pcm_dmaengine snd_hda_scodec_cs35l56 snd_compress rapl snd_hd=
a_cirrus_scodec lenovo_ymc cdc_mbim intel_cstate snd_pcm snd_soc_cs35l56_sh=
ared iwlwifi lenovo_wmi_gamezone processor_thermal_device_pci snd_soc_cs_am=
p_lib lenovo_wmi_other spi_nor processor_thermal_device=0A=
[271447.258771]  snd_timer cs_dsp lenovo_wmi_events cdc_wdm intel_uncore pr=
ocessor_thermal_power_floor lenovo_wmi_capdata uvcvideo pcspkr processor_th=
ermal_wt_hint i2c_i801 snd firmware_attributes_class wmi_bmof lenovo_wmi_he=
lpers lenovo_wmi_hotkey_utilities mtd uvc processor_thermal_wt_req mei_me b=
tusb i2c_smbus videobuf2_vmalloc soundcore cfg80211 intel_pmc_core intel_is=
h_ipc crc8 btmtk i2c_mux intel_vpu processor_thermal_rfim videobuf2_memops =
mei thunderbolt intel_ishtp btbcm processor_thermal_mbox serial_multi_insta=
ntiate cdc_ncm videobuf2_v4l2 intel_pmc_ssram_telemetry btintel platform_te=
mperature_control videobuf2_common cdc_ether processor_thermal_rapl intel_p=
mc_pwrm_telemetry btrtl ideapad_laptop soc_button_array int3403_thermal int=
el_rapl_common usbnet psmouse pmt_telemetry videodev processor_thermal_soc_=
slider bluetooth int3400_thermal pmt_discovery joydev intel_hid mousedev mi=
i pmt_class mc acpi_thermal_rel sparse_keymap hid_sensor_hub pinctrl_meteor=
lake igen6_edac int340x_thermal_zone cdc_acm mac_hid wacom(OE)=0A=
[271447.258818]  acpi_pad acpi_tad rfkill dm_mod usbip_host iTCO_wdt usbip_=
core i2c_dev pkcs8_key_parser sg ntsync crypto_user intel_pmc_bxt zram 842_=
decompress 842_compress lz4hc_compress xe gpu_sched drm_ttm_helper drm_gpuv=
m drm_exec drm_gpusvm_helper drm_suballoc_helper i915 drm_buddy nvme intel_=
gtt spi_intel_pci nvme_core ttm spi_intel i2c_algo_bit nvme_keyring video n=
vme_auth intel_lpss_pci drm_display_helper wmi intel_lpss idma64 cec intel_=
vsec serio_raw hid_multitouch=0A=
[271447.258850] CPU: 9 UID: 1000 PID: 3582585 Comm: python Tainted: G      =
     OE       7.2.9-1-cachyos #1 PREEMPT(full)  458eaf81e04e4bc0eb2f59b8513=
4c9935c8c6b28=0A=
[271447.258858] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE=0A=
[271447.258859] Hardware name: LENOVO 83KJ/LNVNB161216, BIOS QECN29WW 04/16=
/2026=0A=
[271447.258862] RIP: 0010:native_queued_spin_lock_slowpath+0x55/0x260=0A=
[271447.258874] Code: c0 f0 0f ba 2f 08 0f 92 c0 89 c2 c1 e2 08 b9 ff 00 ff=
 ff 23 0f 09 ca 81 fa 00 01 00 00 73 5a 85 c9 74 0e 66 90 80 3f 00 74 07 <f=
3> 90 80 3f 00 75 f9 66 c7 07 01 00 65 48 ff 05 1f 51 1c 02 5b 41=0A=
[271447.258877] RSP: 0018:ffffd294037c7980 EFLAGS: 00000202=0A=
[271447.258880] RAX: 0000000000000000 RBX: ffff8acb2f082700 RCX: 0000000000=
000001=0A=
[271447.258882] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8acb2f=
08284c=0A=
[271447.258883] RBP: 0000000000000040 R08: 0000000000002000 R09: 0000000000=
000000=0A=
[271447.258885] R10: 0000000000000000 R11: ffffffffb45d8eb0 R12: ffffd29403=
7c7a30=0A=
[271447.258887] R13: 0000000000002656 R14: ffff8acb2f08284c R15: 0000000000=
002656=0A=
[271447.258889] FS:  00007ff425ffb6c0(0000) GS:ffff8ad128893000(0000) knlGS=
:0000000000000000=0A=
[271447.258892] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[271447.258893] CR2: 0000555febdd8030 CR3: 0000000147562002 CR4: 0000000008=
f72ef0=0A=
[271447.258896] PKRU: 55555554=0A=
[271447.258896] Call Trace:=0A=
[271447.258899]  <TASK>=0A=
[271447.258905]  _raw_spin_lock_bh+0x2e/0x40=0A=
[271447.258910]  lock_sock_nested+0x35/0x70=0A=
[271447.258916]  tcp_recvmsg+0x68/0x1d0=0A=
[271447.258921]  sock_read_iter+0x1c7/0x1d0=0A=
[271447.258928]  __x64_sys_read+0x233/0x450=0A=
[271447.258933]  do_syscall_64+0xa6/0x3e0=0A=
[271447.258941]  ? arch_exit_to_user_mode_prepare.cold+0x5/0x79=0A=
[271447.258946]  ? do_syscall_64+0xe4/0x3e0=0A=
[271447.258951]  ? __x64_sys_read+0x2ca/0x450=0A=
[271447.258955]  ? do_syscall_64+0xe4/0x3e0=0A=
[271447.258959]  ? arch_exit_to_user_mode_prepare.cold+0x5/0x79=0A=
[271447.258962]  ? do_syscall_64+0xe4/0x3e0=0A=
[271447.258966]  ? do_syscall_64+0x65/0x3e0=0A=
[271447.258971]  entry_SYSCALL_64_after_hwframe+0x76/0x7e=0A=
[271447.258974] RIP: 0033:0x7ff478ab5a22=0A=
[271447.259027] Code: 08 0f 85 b1 32 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89=
 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c=
3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66=0A=
[271447.259029] RSP: 002b:00007ff425ffa2f8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000=0A=
[271447.259032] RAX: ffffffffffffffda RBX: 00007ff4140322b0 RCX: 00007ff478=
ab5a22=0A=
[271447.259034] RDX: 0000000000002656 RSI: 00007ff414156013 RDI: 0000000000=
000017=0A=
[271447.259035] RBP: 00007ff425ffa350 R08: 0000000000000000 R09: 0000000000=
000000=0A=
[271447.259036] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000=
002656=0A=
[271447.259038] R13: 00007ff425ffa3c8 R14: 00007ff425ffb660 R15: 00007ff414=
156013=0A=
[271447.259040]  </TASK>=0A=
[271447.259098] NMI backtrace for cpu 15=0A=
[271447.259105] CPU: 15 UID: 0 PID: 1781 Comm: pr/netcon0 Tainted: G       =
    OE       7.2.9-1-cachyos #1 PREEMPT(full)  458eaf81e04e4bc0eb2f59b85134=
c9935c8c6b28=0A=
[271447.259111] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE=0A=
[271447.259112] Hardware name: LENOVO 83KJ/LNVNB161216, BIOS QECN29WW 04/16=
/2026=0A=
[271447.259114] RIP: 0010:native_queued_spin_lock_slowpath+0x57/0x260=0A=
[271447.259122] Code: 0f ba 2f 08 0f 92 c0 89 c2 c1 e2 08 b9 ff 00 ff ff 23=
 0f 09 ca 81 fa 00 01 00 00 73 5a 85 c9 74 0e 66 90 80 3f 00 74 07 f3 90 <8=
0> 3f 00 75 f9 66 c7 07 01 00 65 48 ff 05 1f 51 1c 02 5b 41 5e 41=0A=
[271447.259124] RSP: 0018:ffffd293c05588d8 EFLAGS: 00000202=0A=
[271447.259127] RAX: 0000000000000000 RBX: ffff8acb65f57000 RCX: 0000000000=
000001=0A=
[271447.259128] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8acb8e=
ce5f00=0A=
[271447.259129] RBP: 000000000000000f R08: 000000006916127b R09: 0000000000=
000001=0A=
[271447.259131] R10: ffffd293c0558a80 R11: 0000000000000000 R12: ffff8acb65=
f570d4=0A=
[271447.259132] R13: ffff8acb8ece5e00 R14: ffff8acf6e25ef00 R15: ffff8aca33=
63b000=0A=
[271447.259134] FS:  0000000000000000(0000) GS:ffff8ad128a13000(0000) knlGS=
:0000000000000000=0A=
[271447.259136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[271447.259137] CR2: 00007f16f88ef00b CR3: 0000000296412001 CR4: 0000000008=
f72ef0=0A=
[271447.259139] PKRU: 55555554=0A=
[271447.259140] Call Trace:=0A=
[271447.259142]  <IRQ>=0A=
[271447.259146]  _raw_spin_lock+0x2a/0x40=0A=
[271447.259150]  sch_direct_xmit+0x98/0x1d0=0A=
[271447.259156]  __dev_queue_xmit+0x415/0xc10=0A=
[271447.259159]  ? __dev_queue_xmit+0x7f/0xc10=0A=
[271447.259165]  ? nf_conntrack_in+0x379/0x780 [nf_conntrack a48fe096bf1928=
2d81b91569c939d30474edf370]=0A=
[271447.259188]  ip_finish_output2+0x262/0x450=0A=
[271447.259192]  ip_output+0xaf/0xf0=0A=
[271447.259194]  ? __pfx_ip_finish_output+0x10/0x10=0A=
[271447.259197]  __ip_queue_xmit+0x263/0x3b0=0A=
[271447.259201]  __tcp_transmit_skb+0x553/0x1210=0A=
[271447.259205]  ? __alloc_skb+0x30d/0x370=0A=
[271447.259207]  tcp_v4_do_rcv+0x87/0x340=0A=
[271447.259211]  tcp_v4_rcv+0x46b/0xde0=0A=
[271447.259214]  ip_protocol_deliver_rcu+0x4c/0x120=0A=
[271447.259218]  ip_local_deliver_finish+0x7d/0xf0=0A=
[271447.259221]  ip_local_deliver+0xa6/0x100=0A=
[271447.259223]  ? __pfx_ip_local_deliver_finish+0x10/0x10=0A=
[271447.259226]  ip_rcv+0x98/0xd0=0A=
[271447.259228]  ? __pfx_ip_rcv_finish+0x10/0x10=0A=
[271447.259231]  process_backlog+0x17d/0x270=0A=
[271447.259234]  __napi_poll+0x2c/0x150=0A=
[271447.259238]  net_rx_action+0x17d/0x270=0A=
[271447.259242]  handle_softirqs+0x126/0x1b0=0A=
[271447.259247]  __local_bh_enable_ip+0x9c/0xc0=0A=
[271447.259251]  </IRQ>=0A=
[271447.259251]  <TASK>=0A=
[271447.259253]  cdc_ncm_tx_fixup+0x5e/0x90 [cdc_ncm 795c10151ac1efda840e31=
6dcec923133205dc76]=0A=
[271447.259261]  usbnet_start_xmit+0x6e/0x880 [usbnet 9bb700a5a823900feca1a=
3fc00259009646b31b2]=0A=
[271447.259268]  netpoll_start_xmit+0x1d8/0x240=0A=
[271447.259273]  netpoll_send_skb+0x182/0x230=0A=
[271447.259277]  send_udp+0x510/0x550 [netconsole 3dd9ae90ed093db9d831cffd8=
ca5dea61ecdd887]=0A=
[271447.259283]  netconsole_write_basic+0xbe/0xd0 [netconsole 3dd9ae90ed093=
db9d831cffd8ca5dea61ecdd887]=0A=
[271447.259289]  nbcon_emit_next_record+0x6e9/0xc50=0A=
[271447.259294]  nbcon_kthread_func+0x2b4/0x360=0A=
[271447.259298]  ? __pfx_nbcon_kthread_func+0x10/0x10=0A=
[271447.259301]  kthread+0x119/0x120=0A=
[271447.259305]  ? __pfx_kthread+0x10/0x10=0A=
[271447.259308]  ret_from_fork+0xee/0x2b0=0A=
[271447.259312]  ? __pfx_kthread+0x10/0x10=0A=
[271447.259314]  ret_from_fork_asm+0x1a/0x30=0A=
[271447.259319]  </TASK>=0A=
=0A=
I can test a patch if that helps. Is this a known issue?=0A=
=0A=
Mikkel=0A=
