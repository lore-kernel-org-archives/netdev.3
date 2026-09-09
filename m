Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F3348C7B;
	Wed,  9 Sep 2026 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923502; cv=none; b=igOl78z0dTXFSwIp2mbXo1Wdh5ZDADuSQeNjHiENNJDJAadOWArQb3FIBTpDPc2mhFuZ9jzeM7NTz5I9dT1sWe2A9+p2O1kac8AT9IDlkvopf6I6ywf3t/jH4+nvKzBYajV57cqNA2uPab2wMZzLLR1q/dX/QAb8cCEjwD5heTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923502; c=relaxed/simple;
	bh=BRwGrfU5Z0rAW7IvaEMnMp7b8lHMtIsZNJYMSdH1G9Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr2JPvG7WSoxzVKyZZsr6o+n6mpqCK8cIUtdZvnqyExLEPk23wBLvsaHbsGe7Jug0roleya/mWjPF/qMorwqEJ1ZLYW05JkOrywDW9Jd94/PJm6swaqQYBAT5PwtHs2nmA7RLBcpMBjvKnJgGiyiNBbnqda34v9v1lG1yoQeURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IBqNukQs; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IBqNukQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788923489; x=1789182689;
	bh=5nkK3I8dOESPdEnrk5253yGEG1lECIstukh3Bvwj5hI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IBqNukQs7tEbaitXf+CRlBCmQ3akpJU8O0UFozqoXfpUTgmrvxeQcvLQ2se/Sp+YF
	 hCLLVBpmMSfz5DomNbyZwvw1ci/8pAVJjARyl2+MxkOQcrQ1yrE+BNhRXkz4BoNZcx
	 uK1FxYWzdKZ+XyX4WKiTsQgt163xtmDkL3u25dOibyqzHF5HMUTDuXAqGvMluJzqQX
	 VkR4nb9kS3XDTL1efGRYxK8vNtanegiejYIAUzDedc4Zgn8GP6Vkh+UD6B6qLgKos9
	 fUJnl9qaRkiTjQCpryC/JSzhP50lVQhSklGCWOWDFbO+pBii7MfEdogqnZbf92NsUM
	 5TvZkJueGQxvg==
Date: Wed, 09 Sep 2026 03:11:22 +0000
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: Esteban Urrutia <esteuwu@proton.me>, Nazar Kompanets <xlie7669@gmail.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: [PATCH v2 2/3] net: ipa: Add IPA v5.1 configuration data
Message-ID: <20260909-sm8450-ipa-v2-2-2deb8b4e91a5@proton.me>
In-Reply-To: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
References: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 0a9f974822474a4b8d402165d845216a156a5f2f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add the configuration data required for IPA v5.1, which is used in the
Qualcomm SM8450 SoC.

Co-developed-by: Nazar Kompanets <xlie7669@gmail.com>
Signed-off-by: Nazar Kompanets <xlie7669@gmail.com>
Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 drivers/net/ipa/Makefile             |   2 +-
 drivers/net/ipa/data/ipa_data-v5.1.c | 476 +++++++++++++++++++++++++++++++=
++++
 drivers/net/ipa/gsi_reg.c            |   1 +
 drivers/net/ipa/ipa_data.h           |   1 +
 drivers/net/ipa/ipa_main.c           |   4 +
 drivers/net/ipa/ipa_reg.c            |   1 +
 6 files changed, 484 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/Makefile b/drivers/net/ipa/Makefile
index e148ec3c1a10..d4995c2e8ca0 100644
--- a/drivers/net/ipa/Makefile
+++ b/drivers/net/ipa/Makefile
@@ -7,7 +7,7 @@ IPA_REG_VERSIONS=09:=3D=093.1 3.5.1 4.2 4.5 4.7 4.9 4.11 5.=
0 5.5
 # Some IPA versions can reuse another set of GSI register definitions.
 GSI_REG_VERSIONS=09:=3D=093.1 3.5.1 4.0 4.5 4.9 4.11 5.0
=20
-IPA_DATA_VERSIONS=09:=3D=093.1 3.5.1 4.2 4.5 4.7 4.9 4.11 5.0 5.2 5.5
+IPA_DATA_VERSIONS=09:=3D=093.1 3.5.1 4.2 4.5 4.7 4.9 4.11 5.0 5.1 5.2 5.5
=20
 obj-$(CONFIG_QCOM_IPA)=09+=3D=09ipa.o
=20
diff --git a/drivers/net/ipa/data/ipa_data-v5.1.c b/drivers/net/ipa/data/ip=
a_data-v5.1.c
new file mode 100644
index 000000000000..7d7bc193b774
--- /dev/null
+++ b/drivers/net/ipa/data/ipa_data-v5.1.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (C) 2023-2024 Linaro Ltd. */
+/* Copyright (C) 2026 Nazar Kompanets <xlie7669@gmail.com> */
+/* Copyright (C) 2026 Esteban Urrutia <esteuwu@proton.me> */
+
+#include <linux/array_size.h>
+#include <linux/log2.h>
+
+#include "../ipa_data.h"
+#include "../ipa_endpoint.h"
+#include "../ipa_mem.h"
+#include "../ipa_version.h"
+
+/** enum ipa_resource_type - IPA resource types for an SoC having IPA v5.1=
 */
+enum ipa_resource_type {
+=09/* Source resource types; first must have value 0 */
+=09IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS=09=09=3D 0,
+=09IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS,
+=09IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_BUFF,
+=09IPA_RESOURCE_TYPE_SRC_HPS_DMARS,
+=09IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES,
+
+=09/* Destination resource types; first must have value 0 */
+=09IPA_RESOURCE_TYPE_DST_DATA_SECTORS=09=09=3D 0,
+=09IPA_RESOURCE_TYPE_DST_DPS_DMARS,
+=09IPA_RESOURCE_TYPE_DST_ULSO_SEGMENTS,
+};
+
+/* Resource groups used for an SoC having IPA v5.1 */
+enum ipa_rsrc_group_id {
+=09/* Source resource group identifiers */
+=09IPA_RSRC_GROUP_SRC_UL=09=09=09=09=3D 0,
+=09IPA_RSRC_GROUP_SRC_DL,
+=09IPA_RSRC_GROUP_SRC_DMA,
+=09IPA_RSRC_GROUP_SRC_QDSS,
+=09IPA_RSRC_GROUP_SRC_URLLC,
+=09IPA_RSRC_GROUP_SRC_U_RX_QC,
+=09IPA_RSRC_GROUP_SRC_COUNT,=09/* Last in set; not a source group */
+
+=09/* Destination resource group identifiers */
+=09IPA_RSRC_GROUP_DST_UL=09=09=09=09=3D 0,
+=09IPA_RSRC_GROUP_DST_DL,
+=09IPA_RSRC_GROUP_DST_UNUSED_2,
+=09IPA_RSRC_GROUP_DST_UNUSED_3,
+=09IPA_RSRC_GROUP_DST_UNUSED_4,
+=09IPA_RSRC_GROUP_DST_UC,
+=09IPA_RSRC_GROUP_DST_DRB_IP,
+=09IPA_RSRC_GROUP_DST_COUNT,=09/* Last; not a destination group */
+};
+
+/* QSB configuration data for an SoC having IPA v5.1 */
+static const struct ipa_qsb_data ipa_qsb_data[] =3D {
+=09[IPA_QSB_MASTER_DDR] =3D {
+=09=09.max_writes=09=09=3D 0,
+=09=09.max_reads=09=09=3D 0,=09/* no limit (hardware max) */
+=09=09.max_reads_beats=09=3D 0,
+=09},
+=09[IPA_QSB_MASTER_PCIE] =3D {
+=09=09.max_writes=09=09=3D 0,
+=09=09.max_reads=09=09=3D 0,=09/* no limit (hardware max) */
+=09=09.max_reads_beats=09=3D 0,
+=09},
+};
+
+/* Endpoint configuration data for an SoC having IPA v5.1 */
+static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] =3D {
+=09[IPA_ENDPOINT_AP_COMMAND_TX] =3D {
+=09=09.ee_id=09=09=3D GSI_EE_AP,
+=09=09.channel_id=09=3D 12,
+=09=09.endpoint_id=09=3D 14,
+=09=09.toward_ipa=09=3D true,
+=09=09.channel =3D {
+=09=09=09.tre_count=09=3D 256,
+=09=09=09.event_count=09=3D 256,
+=09=09=09.tlv_count=09=3D 20,
+=09=09},
+=09=09.endpoint =3D {
+=09=09=09.config =3D {
+=09=09=09=09.resource_group=09=3D IPA_RSRC_GROUP_SRC_UL,
+=09=09=09=09.dma_mode=09=3D true,
+=09=09=09=09.dma_endpoint=09=3D IPA_ENDPOINT_AP_LAN_RX,
+=09=09=09=09.tx =3D {
+=09=09=09=09=09.seq_type =3D IPA_SEQ_DMA,
+=09=09=09=09},
+=09=09=09},
+=09=09},
+=09},
+=09[IPA_ENDPOINT_AP_LAN_RX] =3D {
+=09=09.ee_id=09=09=3D GSI_EE_AP,
+=09=09.channel_id=09=3D 13,
+=09=09.endpoint_id=09=3D 16,
+=09=09.toward_ipa=09=3D false,
+=09=09.channel =3D {
+=09=09=09.tre_count=09=3D 256,
+=09=09=09.event_count=09=3D 256,
+=09=09=09.tlv_count=09=3D 9,
+=09=09},
+=09=09.endpoint =3D {
+=09=09=09.config =3D {
+=09=09=09=09.resource_group=09=3D IPA_RSRC_GROUP_DST_UL,
+=09=09=09=09.aggregation=09=3D true,
+=09=09=09=09.status_enable=09=3D true,
+=09=09=09=09.rx =3D {
+=09=09=09=09=09.buffer_size=09=3D 8192,
+=09=09=09=09=09.pad_align=09=3D ilog2(sizeof(u32)),
+=09=09=09=09=09.aggr_time_limit =3D 500,
+=09=09=09=09},
+=09=09=09},
+=09=09},
+=09},
+=09[IPA_ENDPOINT_AP_MODEM_TX] =3D {
+=09=09.ee_id=09=09=3D GSI_EE_AP,
+=09=09.channel_id=09=3D 11,
+=09=09.endpoint_id=09=3D 2,
+=09=09.toward_ipa=09=3D true,
+=09=09.channel =3D {
+=09=09=09.tre_count=09=3D 512,
+=09=09=09.event_count=09=3D 512,
+=09=09=09.tlv_count=09=3D 25,
+=09=09},
+=09=09.endpoint =3D {
+=09=09=09.filter_support=09=3D true,
+=09=09=09.config =3D {
+=09=09=09=09.resource_group=09=3D IPA_RSRC_GROUP_SRC_UL,
+=09=09=09=09.checksum       =3D true,
+=09=09=09=09.qmap=09=09=3D true,
+=09=09=09=09.status_enable=09=3D true,
+=09=09=09=09.tx =3D {
+=09=09=09=09=09.seq_type =3D IPA_SEQ_2_PASS_SKIP_LAST_UC,
+=09=09=09=09=09.status_endpoint =3D
+=09=09=09=09=09=09IPA_ENDPOINT_MODEM_AP_RX,
+=09=09=09=09},
+=09=09=09},
+=09=09},
+=09},
+=09[IPA_ENDPOINT_AP_MODEM_RX] =3D {
+=09=09.ee_id=09=09=3D GSI_EE_AP,
+=09=09.channel_id=09=3D 1,
+=09=09.endpoint_id=09=3D 23,
+=09=09.toward_ipa=09=3D false,
+=09=09.channel =3D {
+=09=09=09.tre_count=09=3D 256,
+=09=09=09.event_count=09=3D 256,
+=09=09=09.tlv_count=09=3D 9,
+=09=09},
+=09=09.endpoint =3D {
+=09=09=09.config =3D {
+=09=09=09=09.resource_group=09=3D IPA_RSRC_GROUP_DST_UL,
+=09=09=09=09.checksum       =3D true,
+=09=09=09=09.qmap=09=09=3D true,
+=09=09=09=09.aggregation=09=3D true,
+=09=09=09=09.rx =3D {
+=09=09=09=09=09.buffer_size=09=3D 8192,
+=09=09=09=09=09.aggr_time_limit =3D 500,
+=09=09=09=09=09.aggr_close_eof=09=3D true,
+=09=09=09=09},
+=09=09=09},
+=09=09},
+=09},
+=09[IPA_ENDPOINT_MODEM_AP_TX] =3D {
+=09=09.ee_id=09=09=3D GSI_EE_MODEM,
+=09=09.channel_id=09=3D 0,
+=09=09.endpoint_id=09=3D 12,
+=09=09.toward_ipa=09=3D true,
+=09=09.endpoint =3D {
+=09=09=09.filter_support=09=3D true,
+=09=09},
+=09},
+=09[IPA_ENDPOINT_MODEM_AP_RX] =3D {
+=09=09.ee_id=09=09=3D GSI_EE_MODEM,
+=09=09.channel_id=09=3D 7,
+=09=09.endpoint_id=09=3D 21,
+=09=09.toward_ipa=09=3D false,
+=09},
+=09[IPA_ENDPOINT_MODEM_DL_NLO_TX] =3D {
+=09=09.ee_id=09=09=3D GSI_EE_MODEM,
+=09=09.channel_id=09=3D 2,
+=09=09.endpoint_id=09=3D 15,
+=09=09.toward_ipa=09=3D true,
+=09=09.endpoint =3D {
+=09=09=09.filter_support=09=3D true,
+=09=09},
+=09},
+};
+
+/* Source resource configuration data for an SoC having IPA v5.1 */
+static const struct ipa_resource ipa_resource_src[] =3D {
+=09[IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS] =3D {
+=09=09.limits[IPA_RSRC_GROUP_SRC_UL] =3D {
+=09=09=09.min =3D 7,=09.max =3D 12,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_SRC_URLLC] =3D {
+=09=09=09.min =3D 1,=09.max =3D 63,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_SRC_U_RX_QC] =3D {
+=09=09=09.min =3D 0,=09.max =3D 63,
+=09=09},
+=09},
+=09[IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS] =3D {
+=09=09.limits[IPA_RSRC_GROUP_SRC_UL] =3D {
+=09=09=09.min =3D 21,=09.max =3D 21,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_SRC_URLLC] =3D {
+=09=09=09.min =3D 10,=09.max =3D 10,
+=09=09},
+=09},
+=09[IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_BUFF] =3D {
+=09=09.limits[IPA_RSRC_GROUP_SRC_UL] =3D {
+=09=09=09.min =3D 33,=09.max =3D 33,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_SRC_URLLC] =3D {
+=09=09=09.min =3D 20,=09.max =3D 20,
+=09=09},
+=09},
+=09[IPA_RESOURCE_TYPE_SRC_HPS_DMARS] =3D {
+=09=09.limits[IPA_RSRC_GROUP_SRC_UL] =3D {
+=09=09=09.min =3D 0,=09.max =3D 63,
+=09=09},
+=09=09/* Marked as unused downstream */
+=09=09.limits[IPA_RSRC_GROUP_SRC_DMA] =3D {
+=09=09=09.min =3D 0,=09.max =3D 63,
+=09=09},
+=09=09/* Marked as unused downstream */
+=09=09.limits[IPA_RSRC_GROUP_SRC_QDSS] =3D {
+=09=09=09.min =3D 0,=09.max =3D 63,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_SRC_URLLC] =3D {
+=09=09=09.min =3D 1,=09.max =3D 63,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_SRC_U_RX_QC] =3D {
+=09=09=09.min =3D 0,=09.max =3D 63,
+=09=09},
+=09},
+=09[IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES] =3D {
+=09=09.limits[IPA_RSRC_GROUP_SRC_UL] =3D {
+=09=09=09.min =3D 38,=09.max =3D 38,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_SRC_URLLC] =3D {
+=09=09=09.min =3D 16,=09.max =3D 16,
+=09=09},
+=09},
+};
+
+/* Destination resource configuration data for an SoC having IPA v5.1 */
+static const struct ipa_resource ipa_resource_dst[] =3D {
+=09[IPA_RESOURCE_TYPE_DST_DATA_SECTORS] =3D {
+=09=09.limits[IPA_RSRC_GROUP_DST_UL] =3D {
+=09=09=09.min =3D 6,=09.max =3D 6,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_DST_DL] =3D {
+=09=09=09.min =3D 5,=09.max =3D 5,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_DST_DRB_IP] =3D {
+=09=09=09.min =3D 39,=09.max =3D 39,
+=09=09},
+=09},
+=09[IPA_RESOURCE_TYPE_DST_DPS_DMARS] =3D {
+=09=09.limits[IPA_RSRC_GROUP_DST_UL] =3D {
+=09=09=09.min =3D 0,=09.max =3D 3,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_DST_DL] =3D {
+=09=09=09.min =3D 0,=09.max =3D 3,
+=09=09},
+=09},
+=09[IPA_RESOURCE_TYPE_DST_ULSO_SEGMENTS] =3D {
+=09=09.limits[IPA_RSRC_GROUP_DST_UL] =3D {
+=09=09=09.min =3D 0,=09.max =3D 63,
+=09=09},
+=09=09.limits[IPA_RSRC_GROUP_DST_DL] =3D {
+=09=09=09.min =3D 0,=09.max =3D 63,
+=09=09},
+=09},
+};
+
+/* Resource configuration data for an SoC having IPA v5.1 */
+static const struct ipa_resource_data ipa_resource_data =3D {
+=09.rsrc_group_dst_count=09=3D IPA_RSRC_GROUP_DST_COUNT,
+=09.rsrc_group_src_count=09=3D IPA_RSRC_GROUP_SRC_COUNT,
+=09.resource_src_count=09=3D ARRAY_SIZE(ipa_resource_src),
+=09.resource_src=09=09=3D ipa_resource_src,
+=09.resource_dst_count=09=3D ARRAY_SIZE(ipa_resource_dst),
+=09.resource_dst=09=09=3D ipa_resource_dst,
+};
+
+/* IPA-resident memory region data for an SoC having IPA v5.1 */
+static const struct ipa_mem ipa_mem_local_data[] =3D {
+=09{
+=09=09.id=09=09=3D IPA_MEM_UC_EVENT_RING,
+=09=09.offset=09=09=3D 0x0000,
+=09=09.size=09=09=3D 0x1000,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_UC_SHARED,
+=09=09.offset=09=09=3D 0x1000,
+=09=09.size=09=09=3D 0x0080,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_UC_INFO,
+=09=09.offset=09=09=3D 0x1080,
+=09=09.size=09=09=3D 0x0200,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V4_FILTER_HASHED,
+=09=09.offset=09=09=3D 0x1288,
+=09=09.size=09=09=3D 0x0078,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V4_FILTER,
+=09=09.offset=09=09=3D 0x1308,
+=09=09.size=09=09=3D 0x0078,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V6_FILTER_HASHED,
+=09=09.offset=09=09=3D 0x1388,
+=09=09.size=09=09=3D 0x0078,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V6_FILTER,
+=09=09.offset=09=09=3D 0x1408,
+=09=09.size=09=09=3D 0x0078,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V4_ROUTE_HASHED,
+=09=09.offset=09=09=3D 0x1488,
+=09=09.size=09=09=3D 0x0098,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V4_ROUTE,
+=09=09.offset=09=09=3D 0x1528,
+=09=09.size=09=09=3D 0x0098,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V6_ROUTE_HASHED,
+=09=09.offset=09=09=3D 0x15c8,
+=09=09.size=09=09=3D 0x0098,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_V6_ROUTE,
+=09=09.offset=09=09=3D 0x1668,
+=09=09.size=09=09=3D 0x0098,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_MODEM_HEADER,
+=09=09.offset=09=09=3D 0x1708,
+=09=09.size=09=09=3D 0x0240,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_AP_HEADER,
+=09=09.offset=09=09=3D 0x1948,
+=09=09.size=09=09=3D 0x01e0,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_MODEM_PROC_CTX,
+=09=09.offset=09=09=3D 0x1b40,
+=09=09.size=09=09=3D 0x0b20,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_AP_PROC_CTX,
+=09=09.offset=09=09=3D 0x2660,
+=09=09.size=09=09=3D 0x0200,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_STATS_QUOTA_MODEM,
+=09=09.offset=09=09=3D 0x2868,
+=09=09.size=09=09=3D 0x0060,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_STATS_QUOTA_AP,
+=09=09.offset=09=09=3D 0x28c8,
+=09=09.size=09=09=3D 0x0048,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_STATS_TETHERING,
+=09=09.offset=09=09=3D 0x2910,
+=09=09.size=09=09=3D 0x03c0,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_STATS_FILTER_ROUTE,
+=09=09.offset=09=09=3D 0x2cd0,
+=09=09.size=09=09=3D 0x0ba0,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_STATS_DROP,
+=09=09.offset=09=09=3D 0x3870,
+=09=09.size=09=09=3D 0x0020,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_MODEM,
+=09=09.offset=09=09=3D 0x3898,
+=09=09.size=09=09=3D 0x0d48,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_NAT_TABLE,
+=09=09.offset=09=09=3D 0x45e0,
+=09=09.size=09=09=3D 0x0900,
+=09=09.canary_count=09=3D 0,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_PDN_CONFIG,
+=09=09.offset=09=09=3D 0x4ee8,
+=09=09.size=09=09=3D 0x0100,
+=09=09.canary_count=09=3D 2,
+=09},
+=09{
+=09=09.id=09=09=3D IPA_MEM_MODEM_STATS_DROP,
+=09=09.offset=09=09=3D 0x4fe8,
+=09=09.size=09=09=3D 0x0018,
+=09=09.canary_count=09=3D 0,
+=09},
+};
+
+/* Memory configuration data for an SoC having IPA v5.1 */
+static const struct ipa_mem_data ipa_mem_data =3D {
+=09.local_count=09=3D ARRAY_SIZE(ipa_mem_local_data),
+=09.local=09=09=3D ipa_mem_local_data,
+=09.imem_addr=09=3D 0x146a8000,
+=09.imem_size=09=3D 0x00002000,
+=09.smem_size=09=3D 0x00009000,
+};
+
+/* Interconnect rates are in 1000 byte/second units */
+static const struct ipa_interconnect_data ipa_interconnect_data[] =3D {
+=09{
+=09=09.name=09=09=09=3D "memory",
+=09=09.peak_bandwidth=09=09=3D 1900000,=09/* 1.9 GBps */
+=09=09.average_bandwidth=09=3D 590000,=09/* 590 MBps */
+=09},
+=09/* Average rate is unused for the next interconnect */
+=09{
+=09=09.name=09=09=09=3D "config",
+=09=09.peak_bandwidth=09=09=3D 76800,=09/* 76.8 MBps */
+=09=09.average_bandwidth=09=3D 0,=09=09/* unused */
+=09},
+};
+
+/* Clock and interconnect configuration data for an SoC having IPA v5.1 */
+static const struct ipa_power_data ipa_power_data =3D {
+=09.core_clock_rate=09=3D 120 * 1000 * 1000,=09/* Hz */
+=09.interconnect_count=09=3D ARRAY_SIZE(ipa_interconnect_data),
+=09.interconnect_data=09=3D ipa_interconnect_data,
+};
+
+/* Configuration data for an SoC having IPA v5.1. */
+const struct ipa_data ipa_data_v5_1 =3D {
+=09.version=09=09=3D IPA_VERSION_5_1,
+=09.qsb_count=09=09=3D ARRAY_SIZE(ipa_qsb_data),
+=09.qsb_data=09=09=3D ipa_qsb_data,
+=09.modem_route_count=09=3D 11,
+=09.endpoint_count=09=09=3D ARRAY_SIZE(ipa_gsi_endpoint_data),
+=09.endpoint_data=09=09=3D ipa_gsi_endpoint_data,
+=09.resource_data=09=09=3D &ipa_resource_data,
+=09.mem_data=09=09=3D &ipa_mem_data,
+=09.power_data=09=09=3D &ipa_power_data,
+};
diff --git a/drivers/net/ipa/gsi_reg.c b/drivers/net/ipa/gsi_reg.c
index e13cf835a013..a57072ba4bef 100644
--- a/drivers/net/ipa/gsi_reg.c
+++ b/drivers/net/ipa/gsi_reg.c
@@ -110,6 +110,7 @@ static const struct regs *gsi_regs(struct gsi *gsi)
 =09=09return &gsi_regs_v4_11;
=20
 =09case IPA_VERSION_5_0:
+=09case IPA_VERSION_5_1:
 =09case IPA_VERSION_5_2:
 =09case IPA_VERSION_5_5:
 =09=09return &gsi_regs_v5_0;
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 3eb9dc2ce339..fe6f7d5bfe88 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -253,6 +253,7 @@ extern const struct ipa_data ipa_data_v4_7;
 extern const struct ipa_data ipa_data_v4_9;
 extern const struct ipa_data ipa_data_v4_11;
 extern const struct ipa_data ipa_data_v5_0;
+extern const struct ipa_data ipa_data_v5_1;
 extern const struct ipa_data ipa_data_v5_2;
 extern const struct ipa_data ipa_data_v5_5;
=20
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 14ac2d2faf7c..84bec461d22c 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -672,6 +672,10 @@ static const struct of_device_id ipa_match[] =3D {
 =09=09.compatible=09=3D "qcom,sdx65-ipa",
 =09=09.data=09=09=3D &ipa_data_v5_0,
 =09},
+=09{
+=09=09.compatible=09=3D "qcom,sm8450-ipa",
+=09=09.data=09=09=3D &ipa_data_v5_1,
+=09},
 =09{
 =09=09.compatible=09=3D "qcom,milos-ipa",
 =09=09.data=09=09=3D &ipa_data_v5_2,
diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
index 30bd69f4c147..5f22ca6295b1 100644
--- a/drivers/net/ipa/ipa_reg.c
+++ b/drivers/net/ipa/ipa_reg.c
@@ -125,6 +125,7 @@ static const struct regs *ipa_regs(enum ipa_version ver=
sion)
 =09case IPA_VERSION_4_11:
 =09=09return &ipa_regs_v4_11;
 =09case IPA_VERSION_5_0:
+=09case IPA_VERSION_5_1:
 =09case IPA_VERSION_5_2:
 =09=09return &ipa_regs_v5_0;
 =09case IPA_VERSION_5_5:

--=20
2.55.0


