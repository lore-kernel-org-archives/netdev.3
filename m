Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48B265623;
	Thu, 13 Aug 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653867; cv=none; b=Xr+/MtBvV72SduIIizieRagAAUP+NY+qUIIWQEW4z3+o9nPRN4DfIn4coTjXrde2zdcVtn2XFp0Ea254QLd2iyrJrCE12H929pDoRFJBX/jyqsZhMgoF3SSXxmvPGgtklDP9E/SarVDk12TYP9n6RAxmLDBYYX7/0sa8oahrwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653867; c=relaxed/simple;
	bh=nHXgU6kw0jxTjeUqVFhM3aiS1O21EJPTid20lcA7tTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4TuzWjwUlLK+ybLTQ4QCFpP/pUKc3lVZHOVDXk7LQ+nIWWtyxyuOTzTWqxFjkzSXLCv9at6e1AlGOgfsKvc+hvgiTSzWHq8Urw1asyH+XvbYg7/BZEh/8a1UKkKzkw62qZDuGPMCD+vpqT0YadSOtHxjWnh1SzmU4OFNWUJzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHIVIuNy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHIVIuNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786653865; x=1818189865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nHXgU6kw0jxTjeUqVFhM3aiS1O21EJPTid20lcA7tTE=;
  b=dHIVIuNy5LpTxtay5cARW9Z4Vg/AErXfgTXcBzR5CMMr9psIgoZVn/GJ
   vHyEHpbkNFRD2jEhYep+cec1RN7WuLQwEO6UzCpJ+jFhDJKbohl4dpKJ8
   UZNdbMUYGVvDkGOuKm6FUzB5hu6yp3pluFAPza7HLFOBWCJ5JkhaayEPI
   +T71s/s2CoN4YfynixY3UKrHA4bgHlCTtwBXJy46Sk5E/4lUGr4OObs53
   g52efOu+M/IWJ1w9QAVmOsPD5JsDd3f6f/pQiAb9IiBYttFLMdYYkJWEW
   3Gkt3qsrbHQxZ3/fU095ccXJqXzG/YeFhsqcBL3Oo7qH69r2tC71bvkx1
   w==;
X-CSE-ConnectionGUID: LXi6zO15R52CetFvomeFgQ==
X-CSE-MsgGUID: g9DHUSy+Q1OlRQGwfuoecg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="98751979"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="98751979"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 13:44:24 -0700
X-CSE-ConnectionGUID: mvq/wqtgRCqh+mNfGbVBoA==
X-CSE-MsgGUID: Xa5DIXDvSHqwTea38w2gSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="264629752"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 13:44:20 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wucHh-00000000WYs-31ZE;
	Thu, 13 Aug 2026 20:44:17 +0000
Date: Fri, 14 Aug 2026 04:44:08 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Switch <kyle.switch@motor-comm.com>, Frank.Sae@motor-comm.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v8] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <202608140410.QYqocPyD-lkp@intel.com>
References: <20260801035236.3560015-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801035236.3560015-1-kyle.switch@motor-comm.com>

Hi Kyle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Switch/net-phy-Add-driver-for-Motorcomm-Quad-2-5GbE-phy/20260812-155449
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260801035236.3560015-1-kyle.switch%40motor-comm.com
patch subject: [PATCH net-next v8] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
config: i386-randconfig-141 (https://download.01.org/0day-ci/archive/20260814/202608140410.QYqocPyD-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608140410.QYqocPyD-lkp@intel.com/

smatch warnings:
drivers/net/phy/motorcomm.c:1450 yt8824_extern_config_sds_init_paged() warn: unsigned 'data' is never less than zero.
drivers/net/phy/motorcomm.c:1673 yt8824_internal_config_init_paged() warn: missing error code? 'ret'

vim +/data +1450 drivers/net/phy/motorcomm.c

  1220	
  1221	/**
  1222	 * yt8824_extern_config_sds_init_paged() - config external phy8824 sds init
  1223	 * @phydev: target phy_device struct
  1224	 *
  1225	 *
  1226	 * Returns: 0 or negative errno code
  1227	 */
  1228	static int yt8824_extern_config_sds_init_paged(struct phy_device *phydev)
  1229	{
  1230		struct yt8824_shared_priv *shared_priv;
  1231		int ret = 0, old_page;
  1232		int val_1, val_2, val_3, tmp;
  1233		u16 data = 0;
  1234		int port;
  1235	
  1236		shared_priv = phy_package_get_priv(phydev);
  1237		port = phydev->mdio.addr - shared_priv->offset;
  1238		if (port < 0)
  1239			return -EINVAL;
  1240		old_page = phy_select_page(phydev, YT8824_RSSR_USXGMII_SPACE);
  1241		if (old_page < 0)
  1242			goto err_restore_page;
  1243	
  1244		/* read efuse */
  1245		val_1 = ytphy_read_top_ext(phydev, 0xa13e);
  1246		if (val_1 < 0)
  1247			goto err_restore_page;
  1248	
  1249		val_2 = ytphy_read_top_ext(phydev, 0xa13f);
  1250		if (val_2 < 0)
  1251			goto err_restore_page;
  1252	
  1253		val_3 = ytphy_read_top_ext(phydev, 0xa140);
  1254		if (val_3 < 0)
  1255			goto err_restore_page;
  1256	
  1257		if (port == 0) {
  1258			/* Serdes optimization */
  1259			ret = ytphy_write_ext(phydev, 0x04be, 0x000d);
  1260			if (ret < 0)
  1261				goto err_restore_page;
  1262	
  1263			ret = ytphy_write_ext(phydev, 0x049f, 0x7ded);
  1264			if (ret < 0)
  1265				goto err_restore_page;
  1266	
  1267			ret = ytphy_write_ext(phydev, 0x04a9, 0x009f);
  1268			if (ret < 0)
  1269				goto err_restore_page;
  1270	
  1271			/* analog CDR */
  1272			ret = ytphy_write_ext(phydev, 0x0406, 0x0800);
  1273			if (ret < 0)
  1274				goto err_restore_page;
  1275	
  1276			/* optimized VCO */
  1277			ret = ytphy_write_ext(phydev, 0x0438, 0x9024);
  1278			if (ret < 0)
  1279				goto err_restore_page;
  1280	
  1281			ret = ytphy_write_ext(phydev, 0x0439, 0x00c0);
  1282			if (ret < 0)
  1283				goto err_restore_page;
  1284	
  1285			/* optimized PLL lock */
  1286			ret = ytphy_read_ext(phydev, 0x0429);
  1287			if (ret < 0)
  1288				goto err_restore_page;
  1289	
  1290			ret &= ~(BIT(13) | BIT(12));
  1291			tmp = (val_1 & (BIT(7) | BIT(6))) >> 6;
  1292			ret |= (tmp << 12);
  1293			ret = ytphy_write_ext(phydev, 0x0429, ret);
  1294			if (ret < 0)
  1295				goto err_restore_page;
  1296	
  1297			ret = ytphy_read_ext(phydev, 0x0441);
  1298			if (ret < 0)
  1299				goto err_restore_page;
  1300	
  1301			ret &= ~(BIT(1) | BIT(0));
  1302			tmp = (val_1 & (BIT(5) | BIT(4))) >> 4;
  1303			ret |= tmp;
  1304			ret = ytphy_write_ext(phydev, 0x0441, ret);
  1305			if (ret < 0)
  1306				goto err_restore_page;
  1307	
  1308			ret = ytphy_read_ext(phydev, 0x042b);
  1309			if (ret < 0)
  1310				goto err_restore_page;
  1311	
  1312			ret &= ~(BIT(13) | BIT(12));
  1313			tmp = (val_3 & (BIT(1) | BIT(0)));
  1314			ret |= (tmp << 12);
  1315			ret = ytphy_write_ext(phydev, 0x042b, ret);
  1316			if (ret < 0)
  1317				goto err_restore_page;
  1318	
  1319			ret = ytphy_write_ext(phydev, 0x043a, 0x1006);
  1320			if (ret < 0)
  1321				goto err_restore_page;
  1322	
  1323			ret = ytphy_write_ext(phydev, 0x042a, 0xf070);
  1324			if (ret < 0)
  1325				goto err_restore_page;
  1326	
  1327			/* cable length threshold */
  1328			ret = ytphy_write_ext(phydev, 0x0491, 0x007f);
  1329			if (ret < 0)
  1330				goto err_restore_page;
  1331	
  1332			ret = ytphy_write_ext(phydev, 0x0492, 0x7f7f);
  1333			if (ret < 0)
  1334				goto err_restore_page;
  1335	
  1336			/* Serdes training threshold */
  1337			ret = ytphy_write_ext(phydev, 0x0454, 0x0f14);
  1338			if (ret < 0)
  1339				goto err_restore_page;
  1340	
  1341			ret = ytphy_write_ext(phydev, 0x0497, 0x0a44);
  1342			if (ret < 0)
  1343				goto err_restore_page;
  1344	
  1345			/* digital eye diagram of SerDes */
  1346			ret = ytphy_write_ext(phydev, 0x04cd, 0x0000);
  1347			if (ret < 0)
  1348				goto err_restore_page;
  1349	
  1350			/* Serdes LDO */
  1351			ret = ytphy_read_ext(phydev, 0x04b5);
  1352			if (ret < 0)
  1353				goto err_restore_page;
  1354	
  1355			ret &= ~(BIT(6) | BIT(5) | BIT(4));
  1356			tmp = (val_2 & (BIT(4) | BIT(3) | BIT(2))) >> 2;
  1357			ret |= (tmp << 4);
  1358			ret = ytphy_write_ext(phydev, 0x04b5, ret);
  1359			if (ret < 0)
  1360				goto err_restore_page;
  1361	
  1362			ret = ytphy_read_ext(phydev, 0x04b4);
  1363			if (ret < 0)
  1364				goto err_restore_page;
  1365	
  1366			ret &= ~(BIT(10) | BIT(9) | BIT(8));
  1367			tmp = (val_2 & (BIT(7) | BIT(6) | BIT(5))) >> 5;
  1368			ret |= (tmp << 8);
  1369			ret = ytphy_write_ext(phydev, 0x04b4, ret);
  1370			if (ret < 0)
  1371				goto err_restore_page;
  1372	
  1373			/* optimized Serdes RX */
  1374			ret = ytphy_write_ext(phydev, 0x04af, 0x45e3);
  1375			if (ret < 0)
  1376				goto err_restore_page;
  1377	
  1378			ret = ytphy_write_ext(phydev, 0x048a, 0x0fff);
  1379			if (ret < 0)
  1380				goto err_restore_page;
  1381	
  1382			ret = ytphy_write_ext(phydev, 0x0408, 0x7c00);
  1383			if (ret < 0)
  1384				goto err_restore_page;
  1385	
  1386			ret = ytphy_write_ext(phydev, 0x04d6, 0x007f);
  1387			if (ret < 0)
  1388				goto err_restore_page;
  1389	
  1390			ret = ytphy_write_ext(phydev, 0x044f, 0xff08);
  1391			if (ret < 0)
  1392				goto err_restore_page;
  1393	
  1394			/* optimized Serdes TX */
  1395			ret = ytphy_write_ext(phydev, 0x048e, 0x7d00);
  1396			if (ret < 0)
  1397				goto err_restore_page;
  1398	
  1399			ret = ytphy_write_ext(phydev, 0x000d, 0x0606);
  1400			if (ret < 0)
  1401				goto err_restore_page;
  1402	
  1403			/* Serdes manual config */
  1404			ret = ytphy_write_ext(phydev, 0x04b0, 0x0804);
  1405			if (ret < 0)
  1406				goto err_restore_page;
  1407	
  1408			ret = ytphy_write_ext(phydev, 0x04b1, 0x7074);
  1409			if (ret < 0)
  1410				goto err_restore_page;
  1411	
  1412			ret = ytphy_write_ext(phydev, 0x04af, 0x45e7);
  1413			if (ret < 0)
  1414				goto err_restore_page;
  1415	
  1416			/* restart calibration */
  1417			ret = ytphy_write_ext(phydev, 0x0003, 0x5603);
  1418			if (ret < 0)
  1419				goto err_restore_page;
  1420	
  1421			ret = ytphy_write_ext(phydev, 0x0492, 0x7fff);
  1422			if (ret < 0)
  1423				goto err_restore_page;
  1424	
  1425			ret = ytphy_write_ext(phydev, 0x0492, 0x7f7f);
  1426			if (ret < 0)
  1427				goto err_restore_page;
  1428	
  1429			ret = ytphy_write_ext(phydev, 0x2000, 0x0040);
  1430			if (ret < 0)
  1431				goto err_restore_page;
  1432	
  1433			ret = ytphy_write_ext(phydev, 0x2000, 0x0000);
  1434			if (ret < 0)
  1435				goto err_restore_page;
  1436		}
  1437	
  1438		/* TX preamble padded to 8; RX IPG always > 8 */
  1439		ret = __phy_read(phydev, MII_RESV1);
  1440		if (ret < 0)
  1441			goto err_restore_page;
  1442		ret &= ~YT8824_SDS_CFG_MIN_PRE_MASK;
  1443		ret |= YT8824_SDS_TX_PRE_PADDING;
  1444		ret |= YT8824_SDS_EN_FILL_PRE;
  1445		ret = __phy_write(phydev, MII_RESV1, ret);
  1446		if (ret < 0)
  1447			goto err_restore_page;
  1448	
  1449		data = __phy_read(phydev, MII_BMCR);
> 1450		if (data < 0)
  1451			goto err_restore_page;
  1452		data |= BMCR_RESET;
  1453		data |= BMCR_ANENABLE;
  1454		ret = __phy_write(phydev, MII_BMCR, data);
  1455		if (ret < 0)
  1456			goto err_restore_page;
  1457	
  1458	err_restore_page:
  1459		return phy_restore_page(phydev, old_page, ret);
  1460	}
  1461	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
